#pragma once

#include <optional>

#include <CS2/Classes/Entities/C_CSPlayerPawn.h>
#include <CS2/Constants/EntityHandle.h>
#include <FeatureHelpers/LifeState.h>
#include <FeatureHelpers/TeamNumber.h>
#include <Utils/ColorUtils.h>

#include "BaseEntity.h"
#include "PlayerWeapons.h"

class EntityFromHandleFinder;

template <typename HookContext>
class PlayerController;

template <typename HookContext>
class PlayerPawn {
public:
    PlayerPawn(HookContext& hookContext, cs2::C_CSPlayerPawn* playerPawn) noexcept
        : hookContext{hookContext}
        , playerPawn{playerPawn}
    {
    }

    [[nodiscard]] decltype(auto) baseEntity() const noexcept
    {
        return hookContext.template make<BaseEntity>(playerPawn);
    }

    [[nodiscard]] decltype(auto) weapons() const noexcept
    {
        const auto weaponServices = hookContext.gameDependencies().playerPawnDeps.offsetToWeaponServices.of(playerPawn).valueOr(nullptr);
        if (!weaponServices)
            return hookContext.template make<PlayerWeapons>(nullptr);
        return hookContext.template make<PlayerWeapons>(hookContext.gameDependencies().weaponServicesDeps.offsetToWeapons.of(weaponServices).get());
    }

    [[nodiscard]] TeamNumber teamNumber() const noexcept
    {
        return TeamNumber{hookContext.gameDependencies().entityDeps.offsetToTeamNumber.of(playerPawn).valueOr({})};
    }

    [[nodiscard]] std::optional<bool> isAlive() const noexcept
    {
        const auto lifestate = hookContext.gameDependencies().entityDeps.offsetToLifeState.of(playerPawn).get();
        if (lifestate)
            return LifeState{*lifestate} == LifeState::Alive;
        return {};
    }

    [[nodiscard]] decltype(auto) playerController() const noexcept
    {
        if (!hookContext.template requestDependency<EntityFromHandleFinder>())
            return hookContext.template make<PlayerController>(nullptr);

        const auto playerControllerHandle = hookContext.gameDependencies().playerPawnDeps.offsetToPlayerController.of(playerPawn).get();
        if (!playerControllerHandle)
            return hookContext.template make<PlayerController>(nullptr);
        return hookContext.template make<PlayerController>(static_cast<cs2::CCSPlayerController*>(hookContext.template getDependency<EntityFromHandleFinder>().getEntityFromHandle(*playerControllerHandle)));
    }

    [[nodiscard]] std::optional<int> health() const noexcept
    {
        return hookContext.gameDependencies().entityDeps.offsetToHealth.of(playerPawn).toOptional();
    }

    [[nodiscard]] std::optional<cs2::Color> healthColor() const noexcept
    {
        if (const auto healthValue = health(); healthValue.has_value())
            return getColorOfHealthFraction(std::clamp(*healthValue, 0, 100) / 100.0f);
        return {};
    }

    [[nodiscard]] std::optional<bool> hasImmunity() const noexcept
    {
        return hookContext.gameDependencies().playerPawnDeps.offsetToPlayerPawnImmunity.of(playerPawn).toOptional();
    }

    [[nodiscard]] std::optional<cs2::Vector> absOrigin() const noexcept
    {
        const auto gameSceneNode = hookContext.gameDependencies().entityDeps.offsetToGameSceneNode.of(playerPawn).get();
        if (!gameSceneNode || !*gameSceneNode)
            return {};
        return hookContext.gameDependencies().gameSceneNodeDeps.offsetToAbsOrigin.of(*gameSceneNode).toOptional();
    }

    [[nodiscard]] bool isControlledByLocalPlayer() const noexcept
    {
        return playerController() == hookContext.localPlayerController();
    }

    [[nodiscard]] std::optional<bool> isEnemy() const noexcept
    {
        return teamNumber() != hookContext.localPlayerController().teamNumber() || teammatesAreEnemies();
    }

    [[nodiscard]] bool isTTorCT() const noexcept
    {
        const auto _teamNumber = teamNumber();
        return _teamNumber == TeamNumber::TT || _teamNumber == TeamNumber::CT;
    }

    [[nodiscard]] std::optional<bool> isPickingUpHostage() const noexcept
    {
        return hookContext.gameDependencies().playerPawnDeps.offsetToIsPickingUpHostage.of(playerPawn).toOptional();
    }

    [[nodiscard]] std::optional<bool> isDefusing() const noexcept
    {
        return hookContext.gameDependencies().playerPawnDeps.offsetToIsDefusing.of(playerPawn).toOptional();
    }

    [[nodiscard]] bool isRescuingHostage() const noexcept
    {
        const auto hostageServices = hookContext.gameDependencies().playerPawnDeps.offsetToHostageServices.of(playerPawn).valueOr(nullptr);
        if (!hostageServices)
            return false;

        if (!hookContext.template requestDependency<EntityFromHandleFinder>())
            return false;

        return hookContext.template getDependency<EntityFromHandleFinder>().getEntityFromHandle(hookContext.gameDependencies().hostageServicesDeps.offsetToCarriedHostage.of(hostageServices).valueOr(cs2::CEntityHandle{cs2::INVALID_EHANDLE_INDEX})) != nullptr;
    }

    [[nodiscard]] float getRemainingFlashBangTime() const noexcept
    {
        const auto curTime = hookContext.globalVars().curtime();
        if (!curTime)
            return 0.0f;
        const auto flashBangEndTime = hookContext.gameDependencies().playerPawnDeps.offsetToFlashBangEndTime.of(playerPawn).get();
        if (!flashBangEndTime)
            return 0.0f;
        if (*flashBangEndTime <= *curTime)
            return 0.0f;
        return *flashBangEndTime - *curTime;
    }

    [[nodiscard]] cs2::C_CSWeaponBase* getActiveWeapon() const noexcept
    {
        if (!hookContext.template requestDependency<EntityFromHandleFinder>())
            return nullptr;

        const auto weaponServices = hookContext.gameDependencies().playerPawnDeps.offsetToWeaponServices.of(playerPawn).valueOr(nullptr);
        if (!weaponServices)
            return nullptr;

        return static_cast<cs2::C_CSWeaponBase*>(hookContext.template getDependency<EntityFromHandleFinder>().getEntityFromHandle(hookContext.gameDependencies().weaponServicesDeps.offsetToActiveWeapon.of(weaponServices).valueOr(cs2::CEntityHandle{cs2::INVALID_EHANDLE_INDEX})));
    }

private:    
    [[nodiscard]] static cs2::Color getColorOfHealthFraction(float healthFraction) noexcept
    {
        return color::HSBtoRGB(color::kRedHue + (color::kGreenHue - color::kRedHue) * healthFraction, 0.7f, 1.0f);
    }

    [[nodiscard]] bool teammatesAreEnemies() const noexcept
    {
        auto conVarAccessor = hookContext.getConVarAccessor();
        if (!conVarAccessor.template requestConVar<cs2::mp_teammates_are_enemies>())
            return true;
        return conVarAccessor.template getConVarValue<cs2::mp_teammates_are_enemies>();
    }

    HookContext& hookContext;
    cs2::C_CSPlayerPawn* playerPawn;
};

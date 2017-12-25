#pragma once

#include "AngelScriptManager.h"
#include "Result.h"

#define SU_IF_ABILITY "Ability"

struct AbilityInfo final {
    std::string Name;
    std::unordered_map<std::string, boost::any> Arguments;
};

struct CharacterInfo final {
    std::string Name;
    std::string Description;
    std::vector<AbilityInfo> Abilities;

    static std::shared_ptr<CharacterInfo> LoadFromToml(const boost::filesystem::path &path);
};

class Character final {
private:
    asIScriptObject* LoadAbility(boost::filesystem::path spath);
    void CallOnEvent(const char *decl);

public:
    std::shared_ptr<CharacterInfo> Info;
    std::shared_ptr<AngelScript> ScriptInterface;
    std::shared_ptr<Result> TargetResult;
    std::vector<asIScriptObject*> Abilities;
    std::vector<asITypeInfo*> AbilityTypes;
    asIScriptContext *context;

    Character(std::shared_ptr<AngelScript> script, std::shared_ptr<Result> result, std::shared_ptr<CharacterInfo> info);
    ~Character();

    void Initialize();
    void OnStart();
    void OnJusticeCritical();
    void OnJustice();
    void OnAttack();
    void OnMiss();
    void OnFinish();

};

class ExecutionManager;
void RegisterCharacterTypes(ExecutionManager *exm);
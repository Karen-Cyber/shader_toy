#ifndef CONFIG_H
#define CONFIG_H
#include "yaml-cpp/yaml.h"
#include <string>

class YAMLconfig
{
private:
    YAML::Node yaml;

public:
    YAMLconfig() {}
    YAMLconfig(const char* filePath) : yaml(YAML::LoadFile(filePath))
    {
        if (yaml.size() == 0)
            std::cerr << "empty file: " << filePath << std::endl;
    }

    bool isLoaded() const
    {
        return yaml.size() > 0;
    }

    bool loadFile(const char* filePath)
    {
        yaml = YAML::LoadFile(filePath);
        return isLoaded();
    }
    
    template <typename Type>
    Type getValue(std::string key)
    {
        if (!isLoaded())
        {
            std::cerr << "empty configuration...\n";
            return Type();
        }
        return yaml[key].as<Type>();
    }
};


#endif
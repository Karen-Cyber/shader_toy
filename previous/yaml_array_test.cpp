#include <iostream>
#include <string>
#include <vector>
#include <typeinfo>

#include "glm/glm.hpp"
#include "glm/gtc/matrix_transform.hpp"
#include "glm/gtc/type_ptr.hpp"

#include "yaml-cpp/yaml.h"

template <typename Type>
Type getConfig(std::string key)
{
    static YAML::Node config = YAML::LoadFile("../config/camera_config.yaml");
    if (!config.size())
    {
        std::cerr << "error: empty config file, occurs in [Type getValueFromYamlConfig(std::string key)]\n";
        exit(-1);
    }
    std::cout << typeid(Type).name() << std::endl;

    return config[key].as<Type>();
}

int main(int argc, char** argv)
{
    YAML::Node config = YAML::LoadFile("../config/camera_config.yaml");
    if (!config.size())
    {
        std::cerr << "empty file\n";
        exit(-1);
    }
    for (YAML::const_iterator iter = config.begin(); iter != config.end(); ++iter)
    {
        std::string key = iter->first.as<std::string>();
        YAML::Node  val = iter->second;
        switch (val.Type())
        {
        case YAML::NodeType::Map:
            std::cout << key << " is type: Map\n";
            break;
        case YAML::NodeType::Scalar:
            std::cout << key << " is type: Scalar\n";
            break;
        case YAML::NodeType::Sequence:
            std::cout << key << " is type: Sequence\n";
            break;
        case YAML::NodeType::Null:
            std::cout << key << " is type: NULL\n";
            break;
        default:
            std::cout << key << " is type: Undefined\n";
            break;
        }
    }

    getConfig<std::vector<float>>("camPos");
    return 0;
}
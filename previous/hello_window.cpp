#include <glad/glad.h>
#include <GLFW/glfw3.h>

#include <yaml-cpp/yaml.h>

#include <iostream>
#include <string>

#include <errorno.h>

// yaml parser
template <typename Type>
Type getConfig(std::string key)
{
    static YAML::Node config = YAML::LoadFile("../config/config.yaml");
    if (!config.size())
    {
        std::cerr << "error: empty config file, occurs in [Type getValueFromYamlConfig(std::string key)]\n";
        exit(EMPTY_CONF);
    }

    return config[key].as<Type>();
}

// callback functions
void framebuffer_size_callback(GLFWwindow* window, int width, int height);
void processInput(GLFWwindow *window);

// ! ================================== main ==================================
int main(int argc, char** argv)
{
    glfwInit();
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    /**
     * @brief if you want to create a full-screen game, you may
     * need a no-border window, use this line:
     * * glfwWindowHint(GLFW_DECORATED, GL_FALSE);
     */
    
    /**
     * @brief for MacOS X:
     * * glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
     */
    GLFWwindow* window = glfwCreateWindow(
        getConfig<int>("WINDOW_WID"), 
        getConfig<int>("WINDOW_HEI"), 
        "LearnOpenGL", NULL, NULL
    );
    if (window == NULL)
    {
        std::cout << "Failed to create GLFW window" << std::endl;
        glfwTerminate();
        return -1;
    }
    glfwMakeContextCurrent(window);

    // callback preparation
    glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);

    // glad preparation
    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress))
    {
        std::cout << "Failed to initialize GLAD" << std::endl;
        return -1;
    }

    // shader loop
    while(!glfwWindowShouldClose(window))
    {
        processInput(window);

        // render part
        glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
        glClear(GL_COLOR_BUFFER_BIT);

        // event bus
        glfwSwapBuffers(window);
        glfwPollEvents();    
    }

    glfwTerminate();
    return 0;
}

void framebuffer_size_callback(GLFWwindow* window, int width, int height)
{
    // callback function for when the shape of window is changed
    glViewport(0, 0, width, height);
}

void processInput(GLFWwindow *window)
{
    if(glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS)
        glfwSetWindowShouldClose(window, true);
}
#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>
#include <stb_image/stb_image.h>
#include <myImplement/shader.h>

#include <yaml-cpp/yaml.h>

#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <random>
#include <ctime>

#include <myImplement/errorno.h>

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
void processInput(GLFWwindow* window);

// other utilities this demo will use
std::vector<float> readFloats(const char* file_path);

// ! ================================== main ==================================
int main(int argc, char** argv)
{
    srand((unsigned int)(time(NULL)));
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

    // some global settings
    stbi_set_flip_vertically_on_load(true);
    glEnable(GL_DEPTH_TEST);

    // shader preparation
    Shader hello_transform(
        // vertex shader
        getConfig<std::string>("shader_vs").c_str(),
        // fragment shader
        getConfig<std::string>("shader_fs").c_str()
    );

    // vertex data preparation
    std::vector<float> vertices = std::move(readFloats(getConfig<std::string>("simple_cube").c_str()));
    // world space positions of our cubes
    std::vector<glm::vec3> cube_positions {
        glm::vec3( 0.0f,  0.0f,  0.0f),
        glm::vec3( 2.0f,  5.0f, -15.0f),
        glm::vec3(-1.5f, -2.2f, -2.5f),
        glm::vec3(-3.8f, -2.0f, -12.3f),
        glm::vec3( 2.4f, -0.4f, -3.5f),
        glm::vec3(-1.7f,  3.0f, -7.5f),
        glm::vec3( 1.3f, -2.0f, -2.5f),
        glm::vec3( 1.5f,  2.0f, -2.5f),
        glm::vec3( 1.5f,  0.2f, -1.5f),
        glm::vec3(-1.3f,  1.0f, -1.5f)
    };

    // attribution config set
    unsigned int VAO;
    glGenVertexArrays(1, &VAO);
    glBindVertexArray(VAO);
    // buffer preparation
    unsigned int VBO;
    /**
     * @brief if the first parameter of 'glGenBuffers' is greater than
     * 1, then the second parameter should be an array of unsigned int
     */
    glGenBuffers(1, &VBO);
    // GPU buffer could only be bounded to one buffer-ID every time
    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, vertices.size() * sizeof(float), &vertices[0], GL_STATIC_DRAW);

    // position attribute
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 5 * sizeof(float), (void*)0);
    glEnableVertexAttribArray(0);
    // texture coord attribute
    glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 5 * sizeof(float), (void*)(3 * sizeof(float)));
    glEnableVertexAttribArray(1);
    
    glBindVertexArray(0);


    unsigned char* data;
    int width, height, channels;
    // texture preparation
    unsigned int texture1;
    glGenTextures(1, &texture1);
    glBindTexture(GL_TEXTURE_2D, texture1);
    // set the texture wrapping parameters
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    // set texture filtering parameters
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    data = stbi_load(
        getConfig<std::string>("image_container").c_str(),
        &width, &height, &channels, 0
    );
    if (data)
    {
        glTexImage2D(
            GL_TEXTURE_2D, 
            0, 
            channels == 3 ? GL_RGB : GL_RGBA, 
            width, height, 0,
            channels == 3 ? GL_RGB : GL_RGBA,
            GL_UNSIGNED_BYTE, data);
    }
    else
    {
        std::cerr << "failed to load texture: " << getConfig<std::string>("image_container") << std::endl;
        exit(EMPTY_TXUR);
    }
    stbi_image_free(data);

    unsigned int texture2;
    glGenTextures(1, &texture2);
    glBindTexture(GL_TEXTURE_2D, texture2);
    // set the texture wrapping parameters
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    // set texture filtering parameters
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    data = stbi_load(
        getConfig<std::string>("image_awesomeface").c_str(),
        &width, &height, &channels, 0
    );
    if (data)
    {
        glTexImage2D(
            GL_TEXTURE_2D, 
            0, 
            channels == 3 ? GL_RGB : GL_RGBA, 
            width, height, 0,
            channels == 3 ? GL_RGB : GL_RGBA,
            GL_UNSIGNED_BYTE, data);
    }
    else
    {
        std::cerr << "failed to load texture: " << getConfig<std::string>("image_container") << std::endl;
        exit(EMPTY_TXUR);
    }
    stbi_image_free(data);


    // shader loop
    // create transformations
    // make sure to initialize matrix to identity matrix first
    glm::mat4 view          = glm::mat4(1.0f);
    glm::mat4 projection    = glm::mat4(1.0f);
    while (!glfwWindowShouldClose(window))
    {
        processInput(window);

        // clear screen and set background colour
        glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
        // glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        glClear(GL_COLOR_BUFFER_BIT);
        glClear(GL_DEPTH_BUFFER_BIT);

        // render the triangle 
        glBindVertexArray(VAO);
        hello_transform.use();
        // bind textures on corresponding texture units
        hello_transform.setInt("texture1", 0);
        glActiveTexture(GL_TEXTURE0);
        glBindTexture(GL_TEXTURE_2D, texture1);
        hello_transform.setInt("texture2", 1);
        glActiveTexture(GL_TEXTURE1);
        glBindTexture(GL_TEXTURE_2D, texture2);

        // camera transformation
        projection = glm::perspective(glm::radians(45.0f), 600.0f / 600.0f, 0.1f, 100.0f);
        view       = glm::translate(glm::mat4(1.0f), glm::vec3(0.0f, 0.0f, -3.0f));
        hello_transform.setMat4("projection", projection);
        hello_transform.setMat4("view", view);

        // model transformation
        for (const glm::vec3& pos : cube_positions)
        {
            glm::mat4 model = glm::mat4(1.0f);
            model = glm::translate(model, pos);
            float angle = float(rand() % 200);
            model = glm::rotate(model, glm::radians(angle), glm::vec3(1.0f, 0.3f, 0.5f));
            hello_transform.setMat4("model", model);
            glDrawArrays(GL_TRIANGLES, 0, 36);
        }

        // event bus
        glfwSwapBuffers(window);
        glfwPollEvents();
    }
    // optional: de-allocate all resources once they've outlived their purpose:
    // ------------------------------------------------------------------------
    glDeleteVertexArrays(1, &VAO);
    glDeleteBuffers(1, &VBO);
    glfwTerminate();
    return 0;
}

void framebuffer_size_callback(GLFWwindow* window, int width, int height)
{
    // callback function for when the shape of window is changed
    glViewport(0, 0, width, height);
}

void processInput(GLFWwindow* window)
{
    if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS)
        glfwSetWindowShouldClose(window, true);
}

std::vector<float> readFloats(const char* file_path)
{
    std::ifstream float_file;
    float_file.open(file_path, std::ios::in);
    if (!float_file)
    {
        std::cerr << "file not exist: " << file_path << std::endl;
        exit(EMPTY_FILE);
    }
    std::string temp;
    std::vector<float> vertices;
    while (!float_file.eof())
    {
        float_file >> temp;
        vertices.push_back(atof(temp.c_str()));
    }
    float_file.close();
    return vertices;
}

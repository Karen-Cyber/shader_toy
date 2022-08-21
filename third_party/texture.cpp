#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <stb_image.h>
#include <shader.h>

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
void processInput(GLFWwindow* window);

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

    stbi_set_flip_vertically_on_load(true);

    // shader preparation
    Shader hello_texture(
        // vertex shader
        "../shader/shader_vertex/hello_texture_vs.glsl",
        // fragment shader
        "../shader/shader_fragment/hello_texture_fs.glsl"
    );

    // vertex data preparation
    float vertices[] = {
        // positions          // colors           // texture coords
         0.5f,  0.5f, 0.0f,   1.0f, 0.0f, 0.0f,   1.0f, 1.0f, // top right
         0.5f, -0.5f, 0.0f,   0.0f, 1.0f, 0.0f,   1.0f, 0.0f, // bottom right
        -0.5f,  0.5f, 0.0f,   1.0f, 1.0f, 0.0f,   0.0f, 1.0f,  // top left 
         0.5f, -0.5f, 0.0f,   0.0f, 1.0f, 0.0f,   1.0f, 0.0f, // bottom right
        -0.5f, -0.5f, 0.0f,   0.0f, 0.0f, 1.0f,   0.0f, 0.0f, // bottom left
        -0.5f,  0.5f, 0.0f,   1.0f, 1.0f, 0.0f,   0.0f, 1.0f  // top left 
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
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

    // position attribute
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 8 * sizeof(float), (void*)0);
    glEnableVertexAttribArray(0);
    // color attribute
    glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 8 * sizeof(float), (void*)(3 * sizeof(float)));
    glEnableVertexAttribArray(1);
    // texture coord attribute
    glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 8 * sizeof(float), (void*)(6 * sizeof(float)));
    glEnableVertexAttribArray(2);
    
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
    int vertices_num = sizeof(vertices) / sizeof(float);
    while (!glfwWindowShouldClose(window))
    {
        processInput(window);

        // render part
        glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
        glClear(GL_COLOR_BUFFER_BIT);

        // render the triangle 
        glBindVertexArray(VAO);
        hello_texture.use();
        // bind textures on corresponding texture units
        hello_texture.setInt("texture1", 0);
        glActiveTexture(GL_TEXTURE0);
        glBindTexture(GL_TEXTURE_2D, texture1);
        hello_texture.setInt("texture2", 1);
        glActiveTexture(GL_TEXTURE1);
        glBindTexture(GL_TEXTURE_2D, texture2);

        glDrawArrays(GL_TRIANGLES, 0, 6);

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
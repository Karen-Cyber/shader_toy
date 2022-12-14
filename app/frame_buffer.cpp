#include "glad/glad.h"
#include "GLFW/glfw3.h"
#include "glm/glm.hpp"
#include "glm/gtc/matrix_transform.hpp"
#include "glm/gtc/type_ptr.hpp"
#include "stb_image/stb_image.h"

#include "myImplement/shader.h"
#include "myImplement/camera.h"
#include "myImplement/config.h"
#include "myImplement/errorno.h"

#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <random>
#include <ctime>


// callback functions
void framebuffer_size_callback(GLFWwindow* window, int width, int height);
void processInput(GLFWwindow* window);
void mouse_callback(GLFWwindow* window, double xpos, double ypos);
void scrol_callback(GLFWwindow* window, double xoff, double yoff);

// other utilities this demo will use
std::vector<float> readFloats(const char* filePath);
unsigned int loadTexture(const char* imagePath);

// global variable
camera testCam;
float deltaTime = 0.0f;
float lastFrame = 0.0f;
float currFrame = 0.0f;

// ! ================================== main ==================================
int main(int argc, char** argv)
{
    YAMLconfig config("../config/config.yaml");
    const int WINDOW_WID = config.getValue<int>("WINDOW_WID");
    const int WINDOW_HEI = config.getValue<int>("WINDOW_HEI");

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
        WINDOW_WID,
        WINDOW_HEI,
        "LearnOpenGL", NULL, NULL
    );
    if (window == NULL)
    {
        std::cout << "Failed to create GLFW window" << std::endl;
        glfwTerminate();
        return -1;
    }
    glfwMakeContextCurrent(window);
    glfwSetInputMode(window, GLFW_CURSOR, GLFW_CURSOR_DISABLED);
    // callback preparation
    glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);
    glfwSetCursorPosCallback(window, mouse_callback);
    glfwSetScrollCallback(window, scrol_callback);

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
    Shader mainShader(
        // vertex shader
        config.getValue<std::string>("main_vs").c_str(),
        // fragment shader
        config.getValue<std::string>("main_fs").c_str()
    );

    Shader sqadShader(
        // vertex shader
        config.getValue<std::string>("sqad_vs").c_str(),
        // fragment shader
        config.getValue<std::string>("sqad_fs").c_str()
    );

    // vertex data preparation
    std::vector<float> cubeVertices = std::move(readFloats(config.getValue<std::string>("simple_cube").c_str()));
    std::vector<float> sqadVertices = std::move(readFloats(config.getValue<std::string>("simple_sqad").c_str()));
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

    // model VAO and VBO settings
    // cube
    unsigned int cubeVAO;
    glGenVertexArrays(1, &cubeVAO);
    glBindVertexArray(cubeVAO);
    unsigned int cubeVBO;
    glGenBuffers(1, &cubeVBO);
    glBindBuffer(GL_ARRAY_BUFFER, cubeVBO);
    glBufferData(GL_ARRAY_BUFFER, cubeVertices.size() * sizeof(float), &cubeVertices[0], GL_STATIC_DRAW);
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 5 * sizeof(float), (void*)0);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 5 * sizeof(float), (void*)(3 * sizeof(float)));
    glEnableVertexAttribArray(1);
    glBindVertexArray(0);
    // screen square
    unsigned int sqadVAO;
    glGenVertexArrays(1, &sqadVAO);
    glBindVertexArray(sqadVAO);
    unsigned int sqadVBO;
    glGenBuffers(1, &sqadVBO);
    glBindBuffer(GL_ARRAY_BUFFER, sqadVBO);
    glBufferData(GL_ARRAY_BUFFER, sqadVertices.size() * sizeof(float), &sqadVertices[0], GL_STATIC_DRAW);
    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 4 * sizeof(float), (void*)0);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 4 * sizeof(float), (void*)(2 * sizeof(float)));
    glEnableVertexAttribArray(1);
    glBindVertexArray(0);

    // render buffer object
    unsigned int FBO;
    glGenFramebuffers(1, &FBO);
    glBindFramebuffer(GL_FRAMEBUFFER, FBO);
    // colour attachment texture
    unsigned int textureColourBuffer;
    glGenTextures(1, &textureColourBuffer);
    glBindTexture(GL_TEXTURE_2D, textureColourBuffer);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, WINDOW_WID, WINDOW_HEI, 0, GL_RGB, GL_UNSIGNED_BYTE, NULL);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, textureColourBuffer, 0);
    // build a render buffer object for render
    unsigned int RBO;
    glGenRenderbuffers(1, &RBO);
    glBindRenderbuffer(GL_RENDERBUFFER, RBO);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH24_STENCIL8, WINDOW_WID, WINDOW_HEI);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_STENCIL_ATTACHMENT, GL_RENDERBUFFER, RBO);
    if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
        std::cout << "ERROR::FRAMEBUFFER:: Framebuffer is not complete!" << std::endl;
    glBindFramebuffer(GL_FRAMEBUFFER, 0);

    testCam = camera("../config/camera_config.yaml");
    unsigned int texture1 = loadTexture(config.getValue<std::string>("image_container").c_str());
    unsigned int texture2 = loadTexture(config.getValue<std::string>("image_awesomeface").c_str());
    // shader loop
    // create transformations
    // make sure to initialize matrix to identity matrix first
    while (!glfwWindowShouldClose(window))
    {
        currFrame = glfwGetTime();
        deltaTime = currFrame - lastFrame;
        lastFrame = currFrame;
        processInput(window);

        glBindFramebuffer(GL_FRAMEBUFFER, FBO);
        glEnable(GL_DEPTH_TEST); // enable depth testing (is disabled for rendering screen-space quad)
        // clear screen and set background colour
        glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
        // glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        glClear(GL_COLOR_BUFFER_BIT);
        glClear(GL_DEPTH_BUFFER_BIT);

        // render the triangle 
        glBindVertexArray(cubeVAO);
        mainShader.use();
        // camera transformation
        mainShader.setMat4(
            "view", 
            testCam.getViewMat()
        );
        mainShader.setMat4(
            "projection", 
            glm::perspective(testCam.getViewFov(), 600.0f / 600.0f, 0.1f, 100.0f)
        );

        // bind textures on corresponding texture units
        mainShader.setInt("texture1", 0);
        glActiveTexture(GL_TEXTURE0);
        glBindTexture(GL_TEXTURE_2D, texture1);
        mainShader.setInt("texture1", 1);
        glActiveTexture(GL_TEXTURE1);
        glBindTexture(GL_TEXTURE_2D, texture2);
        // model transformation
        for (const glm::vec3& pos : cube_positions)
        {
            glm::mat4 model = glm::mat4(1.0f);
            model = glm::translate(model, pos);
            float angle = 90.0f * float(sin(glfwGetTime()));
            model = glm::rotate(model, glm::radians(angle), glm::vec3(1.0f, float(sin(glfwGetTime())), float(cos(glfwGetTime()))));
            mainShader.setMat4("model", model);
            glDrawArrays(GL_TRIANGLES, 0, 36);
        }

        // swap back to normal screen
        glBindFramebuffer(GL_FRAMEBUFFER, 0);
        // glDisable(GL_DEPTH_TEST);
        glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
        glClear(GL_COLOR_BUFFER_BIT);
        glClear(GL_DEPTH_BUFFER_BIT);
        // sqadShader.use();
        // glBindVertexArray(sqadVAO);
        // sqadShader.setInt("screenTexture", 0);
        // glActiveTexture(GL_TEXTURE0);
        // glBindTexture(GL_TEXTURE_2D, textureColourBuffer);
        // glDrawArrays(GL_TRIANGLES, 0, 6);
        mainShader.use();
        glBindVertexArray(cubeVAO);
        mainShader.setInt("texture1", 0);
        glActiveTexture(GL_TEXTURE0);
        glBindTexture(GL_TEXTURE_2D, textureColourBuffer);
        mainShader.setInt("texture1", 1);
        glActiveTexture(GL_TEXTURE1);
        glBindTexture(GL_TEXTURE_2D, textureColourBuffer);
        // model transformation
        for (const glm::vec3& pos : cube_positions)
        {
            glm::mat4 model = glm::mat4(1.0f);
            model = glm::translate(model, pos);
            float angle = 90.0f * float(sin(glfwGetTime()));
            model = glm::rotate(model, glm::radians(angle), glm::vec3(1.0f, float(sin(glfwGetTime())), float(cos(glfwGetTime()))));
            mainShader.setMat4("model", model);
            glDrawArrays(GL_TRIANGLES, 0, 36);
        }

        // event bus
        glfwSwapBuffers(window);
        glfwPollEvents();
    }
    // optional: de-allocate all resources once they've outlived their purpose:
    // ------------------------------------------------------------------------
    glDeleteVertexArrays(1, &cubeVAO);
    glDeleteBuffers(1, &cubeVBO);
    glDeleteVertexArrays(1, &sqadVAO);
    glDeleteBuffers(1, &sqadVBO);
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
    
    if (glfwGetKey(window, GLFW_KEY_W) == GLFW_PRESS)
        testCam.updatePosi(camera::CAMOVEMENT::FORD, deltaTime);
    if (glfwGetKey(window, GLFW_KEY_S) == GLFW_PRESS)
        testCam.updatePosi(camera::CAMOVEMENT::BACK, deltaTime);
    if (glfwGetKey(window, GLFW_KEY_A) == GLFW_PRESS)
        testCam.updatePosi(camera::CAMOVEMENT::LEFT, deltaTime);
    if (glfwGetKey(window, GLFW_KEY_D) == GLFW_PRESS)
        testCam.updatePosi(camera::CAMOVEMENT::RIGH, deltaTime);
}

void mouse_callback(GLFWwindow* window, double xpos, double ypos)
{
    testCam.updateView(xpos, ypos);
}

void scrol_callback(GLFWwindow* window, double xoff, double yoff)
{
    testCam.updateZoom(xoff, yoff);
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

unsigned int loadTexture(const char* imagePath)
{
    // texture preparation
    unsigned char* data;
    int width, height, channels;
    // texture 1
    unsigned int texture;
    glGenTextures(1, &texture);
    glBindTexture(GL_TEXTURE_2D, texture);
    // set the texture wrapping parameters
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    // set texture filtering parameters
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    data = stbi_load(
        imagePath,
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
        std::cerr << "failed to load texture: " << imagePath << std::endl;
        exit(EMPTY_TXUR);
    }
    stbi_image_free(data);
    return texture;
}

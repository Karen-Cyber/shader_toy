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
std::vector<float> readFloats(const char* file_path);

// global variable
camera testCam;
float deltaTime = 0.0f;
float lastFrame = 0.0f;
float currFrame = 0.0f;

int WINDOW_WID;
int WINDOW_HEI;

// ! ================================== main ==================================
int main(int argc, char** argv)
{
    srand((unsigned int)(time(NULL)));
    YAMLconfig config("../config/config.yaml");
    testCam = camera("../config/camera_config.yaml");

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
    WINDOW_WID = config.getValue<int>("WINDOW_WID");
    WINDOW_HEI = config.getValue<int>("WINDOW_HEI");
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
    glfwSetInputMode(window, GLFW_CURSOR, GLFW_CURSOR_DISABLED);
    glEnable(GL_DEPTH_TEST);

    // main scenary shader
    Shader mainShader(
        // vertex shader
        config.getValue<std::string>("main_vs").c_str(),
        // fragment shader
        config.getValue<std::string>("main_fs").c_str()
    );
    // frame buffer shader(off screen shader)
    Shader sqadShader(
        // vertex shader
        config.getValue<std::string>("sqad_vs").c_str(),
        // fragment shader
        config.getValue<std::string>("sqad_fs").c_str()
    );

    Shader testShader(
        // vertex shader
        config.getValue<std::string>("sqad_vs").c_str(),
        // fragment shader
        config.getValue<std::string>("sqad_fs").c_str()
    );

    // vertex data preparation
    std::vector<float> mainVertices = std::move(readFloats(config.getValue<std::string>("simple_cube").c_str()));
    // world space positions of our cubes
    std::vector<glm::vec3> cube_positions 
    {
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

    std::vector<float> sqadVertices
    {
        // top    triangle
        float(WINDOW_WID), float(WINDOW_HEI), 0.0f,
        float(WINDOW_WID), 0.0f, 0.0f,
        0.0f, 0.0f, 0.0f,
        // bottom triangle
        0.0f, 0.0f, 0.0f,
        0.0f, float(WINDOW_HEI), 0.0f,
        float(WINDOW_WID), float(WINDOW_HEI), 0.0f
    };

    std::vector<float> testVertices = std::move(readFloats(config.getValue<std::string>("simple_sqad").c_str()));

    // attribution config set
    //!main config
    unsigned int mainVAO;
    glGenVertexArrays(1, &mainVAO);
    glBindVertexArray(mainVAO);
    // buffer preparation
    /**
     * @brief if the first parameter of 'glGenBuffers' is greater than
     * 1, then the second parameter should be an array of unsigned int
     */
    unsigned int mainVBO;
    glGenBuffers(1, &mainVBO);
    // GPU buffer could only be bounded to one buffer-ID every time
    glBindBuffer(GL_ARRAY_BUFFER, mainVBO);
    glBufferData(GL_ARRAY_BUFFER, mainVertices.size() * sizeof(float), &mainVertices[0], GL_STATIC_DRAW);
    // position attribute
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 5 * sizeof(float), (void*)0);
    glEnableVertexAttribArray(0);
    // texture coord attribute
    glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 5 * sizeof(float), (void*)(3 * sizeof(float)));
    glEnableVertexAttribArray(1);
    glBindVertexArray(0);
    //!sqad config
    unsigned int sqadVAO;
    glGenVertexArrays(1, &sqadVAO);
    glBindVertexArray(sqadVAO);
    // buffer preparation
    unsigned int sqadVBO;
    glGenBuffers(1, &sqadVBO);
    // GPU buffer could only be bounded to one buffer-ID every time
    glBindBuffer(GL_ARRAY_BUFFER, sqadVBO);
    glBufferData(GL_ARRAY_BUFFER, sqadVertices.size() * sizeof(float), &sqadVertices[0], GL_STATIC_DRAW);
    // position attribute
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float), (void*)0);
    glEnableVertexAttribArray(0);
    glBindVertexArray(0);
    //!test config
    unsigned int testVAO;
    glGenVertexArrays(1, &testVAO);
    glBindVertexArray(testVAO);
    // buffer preparation
    unsigned int testVBO;
    glGenBuffers(1, &testVBO);
    // GPU buffer could only be bounded to one buffer-ID every time
    glBindBuffer(GL_ARRAY_BUFFER, testVBO);
    glBufferData(GL_ARRAY_BUFFER, testVertices.size() * sizeof(float), &testVertices[0], GL_STATIC_DRAW);
    // position attribute
    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 4 * sizeof(float), (void*)0);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 4 * sizeof(float), (void*)(2 * sizeof(float)));
    glEnableVertexAttribArray(1);
    glBindVertexArray(0);

    //!========================== texture preparation ==========================
    unsigned int frameBuffer;
    glGenBuffers(1, &frameBuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, frameBuffer);
    // create a colour attachment
    unsigned int textureColourBuffer;
    glGenTextures(1, &textureColourBuffer);
    glBindTexture(GL_TEXTURE_2D, textureColourBuffer); // explicitly set texture type to 2D
    // no preset data in texture unit
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, WINDOW_WID, WINDOW_HEI, 0, GL_RGB, GL_UNSIGNED_BYTE, NULL); 
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, textureColourBuffer, 0);
    // create a renderbuffer object for depth and stencil attachment (we won't be sampling these)
    unsigned int rbo;
    glGenRenderbuffers(1, &rbo);
    glBindRenderbuffer(GL_RENDERBUFFER, rbo);
    // use a single renderbuffer object for both a depth AND stencil buffer
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH24_STENCIL8, WINDOW_WID, WINDOW_HEI);
    // now actually attach it
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_STENCIL_ATTACHMENT, GL_RENDERBUFFER, rbo); 
    // now that we actually created the framebuffer and added  all 
    // attachments we want to check if it is actually complete now
    if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
        std::cerr << "ERROR::FRAMEBUFFER:: Framebuffer is not complete!" << std::endl;
    glBindFramebuffer(GL_FRAMEBUFFER, 0);

    //!backup scheme
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
        config.getValue<std::string>("image_container").c_str(),
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
        std::cerr << "failed to load texture: " << config.getValue<std::string>("image_container") << std::endl;
        exit(EMPTY_TXUR);
    }
    stbi_image_free(data);

    // !========================== shader loop ==========================
    // create transformations
    // make sure to initialize matrix to identity matrix first
    while (!glfwWindowShouldClose(window))
    {
        currFrame = glfwGetTime();
        deltaTime = currFrame - lastFrame;
        lastFrame = currFrame;
        processInput(window);

        // // draw shader toy as texture
        // glBindFramebuffer(GL_FRAMEBUFFER, frameBuffer);
        // glEnable(GL_DEPTH_TEST);
        // glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
        // glClear(GL_COLOR_BUFFER_BIT);
        // // glClear(GL_DEPTH_BUFFER_BIT);
        // glBindVertexArray(sqadVAO);
        // glActiveTexture(GL_TEXTURE0);
        // sqadShader.use();
        // sqadShader.setVec2("iResolution", glm::vec2(float(WINDOW_WID), float(WINDOW_HEI)));
        // sqadShader.setFloat("iTime", glfwGetTime());
        // glDrawArrays(GL_TRIANGLES, 0, 6);

        // glBindFramebuffer(GL_FRAMEBUFFER, 0);
        // glDisable(GL_DEPTH_TEST);
        // glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
        // glClear(GL_COLOR_BUFFER_BIT);
        // testShader.use();
        // glBindVertexArray(testVAO);
        // testShader.setInt("screenTexture", 0);
        // glBindTexture(GL_TEXTURE_2D, textureColourBuffer);
        // glDrawArrays(GL_TRIANGLES, 0, 6);

        glBindFramebuffer(GL_FRAMEBUFFER, 0);
        glEnable(GL_DEPTH_TEST);
        // glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
        glClear(GL_COLOR_BUFFER_BIT);
        glClear(GL_DEPTH_BUFFER_BIT);
        // render the triangle 
        glBindVertexArray(mainVAO);
        mainShader.use();
        // bind textures on corresponding texture units
        mainShader.setInt("shadertoy_tex", 0);
        glActiveTexture(GL_TEXTURE0);
        glBindTexture(GL_TEXTURE_2D, texture1);
        // camera transformation
        mainShader.setMat4(
            "projection", 
            glm::perspective(testCam.getViewFov(), 1.0f, 0.1f, 100.0f)
        );
        mainShader.setMat4(
            "view", 
            testCam.getViewMat()
        );

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



        // now bind back to default framebuffer and draw a quad plane with the attached framebuffer color texture
        glBindFramebuffer(GL_FRAMEBUFFER, 0);
        glBindVertexArray(testVAO);
        glDisable(GL_DEPTH_TEST); // disable depth test so screen-space quad isn't discarded due to depth test.
        // clear all relevant buffers
        glClearColor(1.0f, 1.0f, 1.0f, 1.0f); // set clear color to white (not really necessary actually, since we won't be able to see behind the quad anyways)
        glClear(GL_COLOR_BUFFER_BIT);
        testShader.use();
        // testShader.setInt("screenTexture", 0);
        // glBindTexture(GL_TEXTURE_2D, textureColourBuffer);	// use the color attachment texture as the texture of the quad plane
        glDrawArrays(GL_TRIANGLES, 0, 6);

        // event bus
        glfwSwapBuffers(window);
        glfwPollEvents();
    }
    // optional: de-allocate all resources once they've outlived their purpose:
    // ------------------------------------------------------------------------
    glDeleteVertexArrays(1, &mainVAO);
    glDeleteBuffers(1, &mainVBO);
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
#ifndef CAMERA_H
#define CAMERA_H

#include "myImplement/config.h"
#include "myImplement/errorno.h"
#include "glm/glm.hpp"
#include "glm/gtc/matrix_transform.hpp"
#include "glm/gtc/type_ptr.hpp"

#include <vector>

class camera
{
private:
    float currX; // x component of position coordinate
    float currY; // y component of position coordinate
    float angleYaw;
    float anglePth;

    float speed; // speed of camera transition
    float sensi; // sensitivity of camera movement
    float zofov; // zoom-field of view of camera

    glm::vec3 camPos; // position of camera
    glm::vec3 camFrn; // front vector of caemra
    glm::vec3 camRgh; // right vector of camera
    glm::vec3 camCup; // up vector of camera
    glm::vec3 camWup; // up vector in camera coordinate

    YAMLconfig config;

    enum CAMODE
    {
        FPS, // first person shooting game mode
        ABS  // modeling and abserving mode
    };

public:
    enum CAMOVEMENT
    {
        FORD, // forward
        BACK, // backward
        LEFT, // left
        RIGH  // right
    };


public:
    camera()
    {
        currX = 300.0f;
        currY = 300.0f;

        speed = 2.5f;
        sensi = 0.1f;
        zofov = 45.0f;
        angleYaw = -90.0f;
        anglePth = 0.0f;

        camPos = glm::vec3(0.0f, 0.0f, 0.0f);
        camFrn = glm::vec3(0.0f, 0.0f, -1.0f);
        camWup = glm::vec3(0.0f, 1.0f, 0.0f);
    }
    
    camera(const char* filePath) : config(filePath)
    {
        if (!config.isLoaded())
        {
            std::cerr << "camera initialization failed: empty config file.\n";
            exit(EMPTY_CONF);
        }
        currX = config.getValue<int>("WINDOW_WID") / 2.0f;
        currY = config.getValue<int>("WINDOW_HEI") / 2.0f;

        speed = config.getValue<float>("camSpeed");
        sensi = config.getValue<float>("camSensi");
        zofov = config.getValue<float>("camZoomd");
        angleYaw = config.getValue<float>("angleYaw");
        anglePth = config.getValue<float>("anglePth");

        std::vector<float> temp;
        temp = config.getValue<std::vector<float>>("camPos");
        camPos = glm::vec3(temp[0], temp[1], temp[2]);
        temp = config.getValue<std::vector<float>>("camFrn");
        camFrn = glm::vec3(temp[0], temp[1], temp[2]);
        temp = config.getValue<std::vector<float>>("camWup");
        camWup = glm::vec3(temp[0], temp[1], temp[2]);
    }

    void updatePosi(CAMOVEMENT move, float deltaTime)
    {
        float deltaDist = speed * deltaTime;
        switch (move)
        {
        case FORD:
            camPos += camFrn * deltaDist;
            break;
        case BACK:
            camPos -= camFrn * deltaDist;
            break;
        case LEFT:
            camPos -= camRgh * deltaDist;
            break;
        case RIGH:
            camPos += camRgh * deltaDist;
            break;
        default:
            break;
        }
    }
    void updateZoom(float xoff, float yoff)
    {
        zofov -= yoff * sensi * 0.5;
        if (zofov < 1.0f)
            zofov = 1.0f;
        if (zofov > 45.0f)
            zofov = 45.0f;
    }
    void updateView(float xpos, float ypos)
    {
        float xoff = xpos - currX;
        float yoff = currY - ypos;

        currX = xpos;
        currY = ypos;

        angleYaw += xoff * sensi;
        anglePth += yoff * sensi;
        if (anglePth > 89.0f)
            anglePth = 89.0f;
        if (anglePth < -89.0f)
            anglePth = -89.0f;

        glm::vec3 front;
        front.x = cos(glm::radians(anglePth)) * cos(glm::radians(angleYaw));
        front.y = sin(glm::radians(anglePth));
        front.z = cos(glm::radians(anglePth)) * sin(glm::radians(angleYaw));
        camFrn = glm::normalize(front);
        camRgh = glm::normalize(glm::cross(camFrn, camWup));
        camCup = glm::normalize(glm::cross(camRgh, camFrn));
    }
    glm::mat4 getViewMat() const
    {
        return glm::lookAt(camPos, camPos + camFrn, camWup);
    }
    float getViewFov() const
    {
        return zofov;
    }
};

#endif
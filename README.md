# Pioneer-Robot-Navigation
A straight-forward code to navigate a differential drive mobile robot to a goal position in CoppeliaSim

![image](https://github.com/syauqibilfaqih/Pioneer-Robot-Navigation/assets/70939903/0313d6fc-8e6d-4372-86f9-66fa420baa97)

This system was developed based on a course titled "Control of Mobile Robots" by Dr. Magnus Egerstedt from Georgia Institute of Technology. Instead of using Matlab Simulink, the model was implemented on Pioneer 3-DX mobile robotic platform simulation on CoppeliaSim Edu.

![image](https://github.com/syauqibilfaqih/Pioneer-Robot-Navigation/assets/70939903/a7aab2c8-7f77-4747-a50c-f26668a16aa0)

The code is simply navigating the robot by the following model

![image](https://github.com/syauqibilfaqih/Pioneer-Robot-Navigation/assets/70939903/ff52ded2-3de6-43fa-95f8-9b2f0d31e1ac)

``` 
        posPioneer=sim.getObjectPosition(pioneer,-1)
        oriPioneer=sim.getObjectOrientation(pioneer,-1)
        posTarget=sim.getObjectPosition(targetDummy,-1)
        
        desiredTheta = math.atan2(posTarget[2]-posPioneer[2],posTarget[1]-posPioneer[1])
        
        omega = (desiredTheta - oriPioneer[3])
        vX = v0*math.cos(omega)
        vY = v0*math.sin(omega)
        print(posTarget[1]-posPioneer[1])
        omega = omega*(1.2) --Change the value inside the parentheses to get a better K gain
        vLeft=vX+vY-omega
        vRight=vX+vY+omega
```

Here is the example demo video:

[![Watch the video](https://img.youtube.com/vi/lC1HWtHNNpE/hqdefault.jpg)](https://www.youtube.com/embed/lC1HWtHNNpE)

Reference :
Egerstedt, M. (). Control of Mobile Robots Module 2 Mobile Robots [PowerPoint slides]. School of Electrical and Computer Engineering, Georgia Institute of Technology. www.coursera.org

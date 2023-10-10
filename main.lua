function sysCall_threadmain()
    -- Put some initialization code here
    usensors={-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}
    for i=1,16,1 do
        usensors[i]=sim.getObjectHandle("Pioneer_p3dx_ultrasonicSensor"..i)
    end
    motorLeft=sim.getObjectHandle("Pioneer_p3dx_leftMotor")
    motorRight=sim.getObjectHandle("Pioneer_p3dx_rightMotor")
    pioneer=sim.getObjectHandle("Pioneer_p3dx")
    targetDummy=sim.getObjectHandle("Dummy")
    noDetectionDist=0.5
    maxDetectionDist=0.2
    detect={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
    braitenbergL={-0.2,-0.4,-0.6,-0.8,-1,-1.2,-1.4,-1.6, 0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0}
    braitenbergR={-1.6,-1.4,-1.2,-1,-0.8,-0.6,-0.4,-0.2, 0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0}
    v0=1.5
    
    vLeft=v0
    vRight=v0

    sim.setJointTargetVelocity(motorLeft,vLeft)
    sim.setJointTargetVelocity(motorRight,vRight)
    
    while sim.getSimulationState()~=sim.simulation_advancing_abouttostop do
        posPioneer=sim.getObjectPosition(pioneer,-1)
        oriPioneer=sim.getObjectOrientation(pioneer,-1)
        posTarget=sim.getObjectPosition(targetDummy,-1)
        
        desiredTheta = math.atan2(posTarget[2]-posPioneer[2],posTarget[1]-posPioneer[1])
        
        omega = (desiredTheta - oriPioneer[3])
        vX = v0*math.cos(omega)
        vY = v0*math.sin(omega)
        print(posTarget[1]-posPioneer[1])
        omega = omega*(1.2)
        vLeft=vX+vY-omega
        vRight=vX+vY+omega
        
        if math.abs(posTarget[2]-posPioneer[2])<0.01 and math.abs(posTarget[1]-posPioneer[1])<0.01 then 
            sim.setJointTargetVelocity(motorLeft,0)
            sim.setJointTargetVelocity(motorRight,0)
        else
            sim.setJointTargetVelocity(motorLeft,vLeft)
            sim.setJointTargetVelocity(motorRight,vRight)
        end
    end

    -- Put your main loop here, e.g.:
    --
    -- while sim.getSimulationState()~=sim.simulation_advancing_abouttostop do
    --     local p=sim.getObjectPosition(objHandle,-1)
    --     p[1]=p[1]+0.001
    --     sim.setObjectPosition(objHandle,-1,p)
    --     sim.switchThread() -- resume in next simulation step
    -- end
end

function sysCall_cleanup()
    -- Put some clean-up code here
end

-- See the user manual or the available code snippets for additional callback functions and details

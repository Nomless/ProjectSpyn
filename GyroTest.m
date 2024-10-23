
LEFT_DRIVE_MOTOR = 'D';
RIGHT_DRIVE_MOTOR = 'C';

TURN_SPEED = 45;

brick.beep();

brick.GyroCalibrate(3);

t = 0;

target = 90;

while 1
    angle = brick.GyroAngle(3)
    
    
    pause(0.5);
end
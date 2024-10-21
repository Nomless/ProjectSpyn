TOUCH_PORT = 4;
ULTRASONIC_PORT = 1;
COLOR_PORT = 3;
LEFT_DRIVE_MOTOR = 'D';
RIGHT_DRIVE_MOTOR = 'C';
ARM_MOTOR = 'B';

DRIVE_SPEED = 50;
TURN_SPEED = 20;

touched = false;
completed_check = false;

brick.beep();

brick.MoveMotor(LEFT_DRIVE_MOTOR, -DRIVE_SPEED);
brick.MoveMotor(RIGHT_DRIVE_MOTOR, -DRIVE_SPEED);

while 1
    if ~touched && brick.TouchPressed(TOUCH_PORT)
        disp("Touching wall");
        touched = true;
        completed_check = false;
        brick.MoveMotor(LEFT_DRIVE_MOTOR, DRIVE_SPEED);
        brick.MoveMotor(RIGHT_DRIVE_MOTOR, DRIVE_SPEED);
        pause(0.2);
        brick.StopMotor(LEFT_DRIVE_MOTOR);
        brick.StopMotor(RIGHT_DRIVE_MOTOR);
        continue;
    end
    if touched && ~completed_check
        disp("Looking around");
        disp("Moving Left");
        brick.MoveMotorAngleAbs(ARM_MOTOR, 20, 0, 'Brake'); 
        disp("Waiting");
        brick.WaitForMotor(ARM_MOTOR);
        disp("Getting distance");
        left_distance = brick.UltrasonicDist(ULTRASONIC_PORT);
        disp('Left: ' + left_distance);
        disp("Moving Right");
        brick.MoveMotorAngleAbs(ARM_MOTOR, 20, -180, 'Brake'); 
        disp("Waiting");
        brick.WaitForMotor(ARM_MOTOR);
        disp("Getting distance");
        right_distance = brick.UltrasonicDist(ULTRASONIC_PORT);
        disp('Right: ' + right_distance);
        if left_distance < right_distance
            % move right
            brick.MoveMotor(LEFT_DRIVE_MOTOR, -TURN_SPEED);
            brick.MoveMotor(RIGHT_DRIVE_MOTOR, TURN_SPEED);
            pause(1.7);
            brick.StopMotor(LEFT_DRIVE_MOTOR);
            brick.StopMotor(RIGHT_DRIVE_MOTOR);
        else
            % move left
            brick.MoveMotor(LEFT_DRIVE_MOTOR, TURN_SPEED);
            brick.MoveMotor(RIGHT_DRIVE_MOTOR, -TURN_SPEED);
            pause(1.5);
            brick.StopMotor(LEFT_DRIVE_MOTOR);
            brick.StopMotor(RIGHT_DRIVE_MOTOR);
        end
        touched = false;
        completed_check = true;
    end
    pause(0.1);
end
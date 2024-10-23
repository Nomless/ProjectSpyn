TOUCH_PORT = 1;
ULTRASONIC_PORT = 4;
COLOR_PORT = 3;
LEFT_DRIVE_MOTOR = 'D';
RIGHT_DRIVE_MOTOR = 'C';
ARM_MOTOR = 'B';

DRIVE_SPEED = 50;
TURN_SPEED = 45;

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
        disp("Moving Right");
        brick.MoveMotorAngleAbs(ARM_MOTOR, 20, -180, 'Brake'); 
        disp("Waiting");
        brick.WaitForMotor(ARM_MOTOR);
        disp("Getting distance");
        right_distance = brick.UltrasonicDist(ULTRASONIC_PORT);
        disp('Right');
        disp(right_distance);
        disp("Moving Left");
        brick.MoveMotorAngleAbs(ARM_MOTOR, 20, 0, 'Brake'); 
        disp("Waiting");
        brick.WaitForMotor(ARM_MOTOR);
        disp("Getting distance");
        left_distance = brick.UltrasonicDist(ULTRASONIC_PORT);
        disp('Left');
        disp(left_distance)
        if left_distance < 20 && right_distance > 20
            %move right
            disp("Right 1");
            brick.MoveMotor(LEFT_DRIVE_MOTOR, -TURN_SPEED);
            brick.MoveMotor(RIGHT_DRIVE_MOTOR, TURN_SPEED);
            pause(1.0);
            brick.StopMotor(LEFT_DRIVE_MOTOR);
            brick.StopMotor(RIGHT_DRIVE_MOTOR);
        elseif right_distance < 20 && left_distance > 20
            % move left
            disp("Left 1");
            brick.MoveMotor(LEFT_DRIVE_MOTOR, TURN_SPEED);
            brick.MoveMotor(RIGHT_DRIVE_MOTOR, -TURN_SPEED);
            pause(1.0);
            brick.StopMotor(LEFT_DRIVE_MOTOR);
            brick.StopMotor(RIGHT_DRIVE_MOTOR);
        elseif left_distance < 20 && right_distance < 20
            % turn 180
            brick.MoveMotor(LEFT_DRIVE_MOTOR, TURN_SPEED);
            brick.MoveMotor(RIGHT_DRIVE_MOTOR, -TURN_SPEED);
            pause(2.0);
            brick.StopMotor(LEFT_DRIVE_MOTOR);
            brick.StopMotor(RIGHT_DRIVE_MOTOR);
        elseif left_distance < right_distance
            % move right
            disp("Right 2");
            brick.MoveMotor(LEFT_DRIVE_MOTOR, -TURN_SPEED);
            brick.MoveMotor(RIGHT_DRIVE_MOTOR, TURN_SPEED);
            pause(1.0);
            brick.StopMotor(LEFT_DRIVE_MOTOR);
            brick.StopMotor(RIGHT_DRIVE_MOTOR);
        else
            % move left
            disp("Left 1");
            brick.MoveMotor(LEFT_DRIVE_MOTOR, TURN_SPEED);
            brick.MoveMotor(RIGHT_DRIVE_MOTOR, -TURN_SPEED);
            pause(1.0);
            brick.StopMotor(LEFT_DRIVE_MOTOR);
            brick.StopMotor(RIGHT_DRIVE_MOTOR);
        end
        touched = false;
        completed_check = true;
        brick.MoveMotor(LEFT_DRIVE_MOTOR, -DRIVE_SPEED);
        brick.MoveMotor(RIGHT_DRIVE_MOTOR, -DRIVE_SPEED);
    end
    pause(0.1);
end
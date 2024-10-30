TOUCH_PORT = 4;
ULTRASONIC_PORT = 1;
COLOR_PORT = 3;
LEFT_DRIVE_MOTOR = 'D';
RIGHT_DRIVE_MOTOR = 'C';
ARM_MOTOR = 'B';

% 1 - Black
% 2 - Blue
% 3 - Green
% 4 - Yellow
% 5 - Red
% 6 - White
% 7 - Brown
STOP_COLOR = 5;

DRIVE_SPEED = 60;
LEFT_OFFSET = 0;
TURN_SPEED = 80;

touched = false;

brick.beep();

brick.MoveMotor(LEFT_DRIVE_MOTOR, DRIVE_SPEED + LEFT_OFFSET);
brick.MoveMotor(RIGHT_DRIVE_MOTOR, DRIVE_SPEED);

while 1
    if isnan(brick.TouchPressed(TOUCH_PORT))
        disp("NaN???");
        continue
    end
    if ~touched && brick.TouchPressed(TOUCH_PORT)
        disp("Touching wall");
        touched = true;
        brick.MoveMotor(LEFT_DRIVE_MOTOR, -DRIVE_SPEED);
        brick.MoveMotor(RIGHT_DRIVE_MOTOR, -DRIVE_SPEED);
        pause(0.2);
        brick.StopMotor(LEFT_DRIVE_MOTOR);
        brick.StopMotor(RIGHT_DRIVE_MOTOR);
        continue;
    end
    distance = brick.UltrasonicDist(ULTRASONIC_PORT);
    if touched
        % move right
        brick.MoveMotor(LEFT_DRIVE_MOTOR, TURN_SPEED);
        brick.MoveMotor(RIGHT_DRIVE_MOTOR, -TURN_SPEED);
        pause(1.9);
        brick.StopMotor(LEFT_DRIVE_MOTOR);
        brick.StopMotor(RIGHT_DRIVE_MOTOR);
        touched = false;
        pause(0.5);
        brick.MoveMotor(LEFT_DRIVE_MOTOR, DRIVE_SPEED + LEFT_OFFSET);
        brick.MoveMotor(RIGHT_DRIVE_MOTOR, DRIVE_SPEED);
    elseif brick.ColorCode(COLOR_PORT) == STOP_COLOR
        brick.StopMotor(LEFT_DRIVE_MOTOR);
        brick.StopMotor(RIGHT_DRIVE_MOTOR);
        pause(2);
        brick.MoveMotor(LEFT_DRIVE_MOTOR, DRIVE_SPEED + LEFT_OFFSET);
        brick.MoveMotor(RIGHT_DRIVE_MOTOR, DRIVE_SPEED);
        pause(0.5);
    elseif distance > 40
        pause(0.25);
        % move left
        brick.MoveMotor(LEFT_DRIVE_MOTOR, -TURN_SPEED);
        brick.MoveMotor(RIGHT_DRIVE_MOTOR, TURN_SPEED);
        pause(1.8);
        brick.StopMotor(LEFT_DRIVE_MOTOR);
        brick.StopMotor(RIGHT_DRIVE_MOTOR);
        pause(0.5);
        brick.MoveMotor(LEFT_DRIVE_MOTOR, DRIVE_SPEED + LEFT_OFFSET);
        brick.MoveMotor(RIGHT_DRIVE_MOTOR, DRIVE_SPEED);
        pause(2.5);
    end
    
    pause(0.1);
end
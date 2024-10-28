TOUCH_PORT = 1;
ULTRASONIC_PORT = 4;
COLOR_PORT = 3;
LEFT_DRIVE_MOTOR = 'D';
RIGHT_DRIVE_MOTOR = 'C';
ARM_MOTOR = 'B';

DRIVE_SPEED = 50;
TURN_SPEED = 20;

touched = false;

brick.beep();

brick.MoveMotor(LEFT_DRIVE_MOTOR, -DRIVE_SPEED);
brick.MoveMotor(RIGHT_DRIVE_MOTOR, -DRIVE_SPEED);

while 1
    if ~touched && brick.TouchPressed(TOUCH_PORT)
        disp("Touching wall");
        touched = true;
        brick.MoveMotor(LEFT_DRIVE_MOTOR, DRIVE_SPEED);
        brick.MoveMotor(RIGHT_DRIVE_MOTOR, DRIVE_SPEED);
        pause(0.2);
        brick.StopMotor(LEFT_DRIVE_MOTOR);
        brick.StopMotor(RIGHT_DRIVE_MOTOR);
        continue;
    end
    distance = brick.UltrasonicDist(ULTRASONIC_PORT);
    if touched
        % move right
        brick.MoveMotor(LEFT_DRIVE_MOTOR, -TURN_SPEED);
        brick.MoveMotor(RIGHT_DRIVE_MOTOR, TURN_SPEED);
        pause(1.7);
        brick.StopMotor(LEFT_DRIVE_MOTOR);
        brick.StopMotor(RIGHT_DRIVE_MOTOR);
        touched = false;
        pause(0.5);
        brick.MoveMotor(LEFT_DRIVE_MOTOR, -DRIVE_SPEED);
        brick.MoveMotor(RIGHT_DRIVE_MOTOR, -DRIVE_SPEED);
    elseif distance > 40
        % move left
        brick.MoveMotor(LEFT_DRIVE_MOTOR, TURN_SPEED);
        brick.MoveMotor(RIGHT_DRIVE_MOTOR, -TURN_SPEED);
        pause(1.5);
        brick.StopMotor(LEFT_DRIVE_MOTOR);
        brick.StopMotor(RIGHT_DRIVE_MOTOR);
        pause(0.5);
        brick.MoveMotor(LEFT_DRIVE_MOTOR, -DRIVE_SPEED);
        brick.MoveMotor(RIGHT_DRIVE_MOTOR, -DRIVE_SPEED);
    end
    
    pause(0.1);
end
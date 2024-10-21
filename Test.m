
brick.beep();

while 1
    disp(brick.TouchPressed(1));
    if brick.TouchPressed(1)
        brick.beep();
    end
    pause(0.25)
end
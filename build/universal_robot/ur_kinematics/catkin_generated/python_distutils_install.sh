#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/ngoos/catkin_urdf/src/universal_robot/ur_kinematics"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/ngoos/catkin_urdf/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/ngoos/catkin_urdf/install/lib/python3/dist-packages:/home/ngoos/catkin_urdf/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/ngoos/catkin_urdf/build" \
    "/usr/bin/python3" \
    "/home/ngoos/catkin_urdf/src/universal_robot/ur_kinematics/setup.py" \
    egg_info --egg-base /home/ngoos/catkin_urdf/build/universal_robot/ur_kinematics \
    build --build-base "/home/ngoos/catkin_urdf/build/universal_robot/ur_kinematics" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/ngoos/catkin_urdf/install" --install-scripts="/home/ngoos/catkin_urdf/install/bin"

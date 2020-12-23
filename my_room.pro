TEMPLATE = subdirs

SUBDIRS += \
    my_room_CORE \
    my_room_UI

my_room_UI.depends = my_room_CORE

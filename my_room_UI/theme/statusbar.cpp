/*
 * Copyright (c) 2016 J-P Nurmi
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
*/

#include "statusbar.h"
#include "statusbar_p.h"

QColor StatusBarPrivate::color;
QColor StatusBarPrivate::color2;
StatusNavigationBar::Theme StatusBarPrivate::theme = StatusNavigationBar::Light;

StatusNavigationBar::StatusNavigationBar(QObject *parent) : QObject(parent)
{
}

bool StatusNavigationBar::isAvailable()
{
    return StatusBarPrivate::isAvailable_sys();
}

QColor StatusNavigationBar::navigationBarColor()   //////////// return
{
    return StatusBarPrivate::color2;
}

void StatusNavigationBar::setNavigationBarColor(const QColor &color) //////navigationbar color
{
    StatusBarPrivate::color2 = color;
    StatusBarPrivate::setColor_sys2(color);
}

QColor StatusNavigationBar::statusBarColor()  ///////////// return
{
    return StatusBarPrivate::color;
}

void StatusNavigationBar::setStatusBarColor(const QColor &color)   /////statusbar color
{
    StatusBarPrivate::color = color;
    StatusBarPrivate::setColor_sys(color);
}

StatusNavigationBar::Theme StatusNavigationBar::theme()
{
    return StatusBarPrivate::theme;
}

void StatusNavigationBar::setTheme(Theme theme)
{
    StatusBarPrivate::theme = theme;
    StatusBarPrivate::setTheme_sys(theme);
}

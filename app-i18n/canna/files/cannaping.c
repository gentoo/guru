/*
 * cannaping - the minimal cannaserver check program
 *
 * Copyright (C) 2003 Red Hat, Inc.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 */

/*
 * Bugs & suggestions about this program are welcome:
 * http://bugzilla.redhat.com/
 *
 * 2003/02/04
 * Yukihiro Nakai <ynakai@redhat.com>
 */

#include <stdio.h>
#include <stdlib.h>
#include <canna/jrkanji.h>

int main() {
  char** warning = NULL;
  int res = jrKanjiControl(0, KC_INITIALIZE, (char*)&warning);

  if( res != 0 ) {
    exit(-1);
  } else if( warning ) {
    exit(-1);
  }

  jrKanjiControl(0, KC_FINALIZE, 0);
  return 0;
}

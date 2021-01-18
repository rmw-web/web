#!/usr/bin/env python3

from os.path import abspath, dirname, basename, join, exists
from tzutil.dirreplace import dirreplace

FROM_STRING = """
import {$on} from '@/coffee/$'
"""

TO_STRING = """
import $on from '@/coffee/$/on'
"""

dirreplace(
  dirname(abspath(__file__)),
  FROM_STRING,
  TO_STRING,
)

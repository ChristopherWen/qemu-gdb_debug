#pragma once

.macro adr_global reg, symbol
adrp \reg, \symbol
add \reg, \reg, #:lo12:\symbol
.endm

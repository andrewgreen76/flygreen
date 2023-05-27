from enum import Enum
class Languages(Enum):
    PYTHON = 1
    JAVASCRIPT = 2
    CPLUSPLUS = 3

for lang in Languages:
    print(lang)

Languages.PYTHON
Languages.JAVASCRIPT
Languages.CPLUSPLUS

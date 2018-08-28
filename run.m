addpath('./data/train')
addpath('./data/test')

code = train('/data/train/',7);
test('/data/test/',7, code);

grep -o '^URL=.*' z_target.url | cut -d'=' -f2-

grep 'URL=' z_target.url
grep -o 'URL=' z_target.url
grep -o 'URL=.' z_target.url
grep -o 'URL=..' z_target.url
grep -o 'URL=.*' z_target.url
grep -o 'URL=.*' z_target.url | cut -d'=' -f2-

grep http z_target.url | cut -d'=' -f2-

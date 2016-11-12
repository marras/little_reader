files = files.map (name) => [name.replace(/.*\//, '').replace(/\..*/, ''), name]

names = Object.keys(files)
alert(names)

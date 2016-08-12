{CompositeDisposable} = require 'atom'
{exec} = require 'child_process'

module.exports = GitTools =
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    # Register command that toggles this view
    @subscriptions.add
    atom.commands.add 'atom-workspace', 'git-tools:git-gui': => @git_gui()
    @subscriptions.add
    atom.commands.add 'atom-workspace', 'git-tools:gitk': => @git_k()
    @subscriptions.add
    atom.commands.add(
      'atom-workspace',
      'git-tools:gitk-current-file': => @git_k_cf()
    )

  dir: ->
    editor = atom.workspace.getActivePaneItem()
    if editor == undefined
      undefined
    else
      directoryPath = editor?.getDirectoryPath()

  file: ->
    editor = atom.workspace.getActivePaneItem()
    editor?.buffer.file?.path

  isUndefined: (dir, title) ->
    if dir == undefined
      atom.notifications.addError(
        title ,
        { detail: "Not found!\nOpen file in project." }
      )
      true
    else
      false

  # commands
  git_k: ->
    dir = @dir()
    return if @isUndefined(dir, "Gitk")
    exec 'cd ' + dir + ' && gitk'

  git_k_cf: ->
    file = @file()
    return if @isUndefined(file, "Gitk Current File")
    exec 'cd ' + @dir() + ' && gitk ' + file

  git_gui: ->
    dir = @dir()
    return if @isUndefined(dir, "Git Gui")
    exec 'cd ' + dir + ' && git gui'

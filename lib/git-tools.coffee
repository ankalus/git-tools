{CompositeDisposable} = require 'atom'
{exec} = require 'child_process'
path = require 'path'

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
      ""
    else
      directoryPath = editor?.getDirectoryPath()

  file: ->
    editor = atom.workspace.getActivePaneItem()
    editor?.buffer.file?.path

  git_k: ->
    exec 'cd ' + @dir() + ' && gitk'
    # console.log 'Gitk was opend!'

  git_k_cf: ->
    exec 'cd ' + @dir() + ' && gitk ' + @file()
    # console.log 'Gitk was opend!'

  git_gui: ->
    exec 'cd ' + @dir() + ' && git gui'
    # console.log 'Git Gui was opend!'

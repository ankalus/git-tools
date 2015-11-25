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

  dir: ->
    editor = atom.workspace.getActivePaneItem()
    if editor.buffer == undefined
      ""
    else
      file = editor?.buffer.file
      filePath = file?.path
      path.dirname filePath

  git_k: ->
    exec 'cd ' + @dir() + ' && gitk'
    console.log 'Gitk was opend!'

  git_gui: ->
    exec 'cd ' + @dir() + ' && git gui'
    console.log 'Git Gui was opend!'

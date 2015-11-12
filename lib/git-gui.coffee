{CompositeDisposable} = require 'atom'
{exec} = require 'child_process'
path = require 'path'

module.exports = GitGui =
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace',
                                         'git-gui:open': => @open()

  open: ->
    console.log 'Git Gui was opend!'
    process_architecture = process.platform
    editor = atom.workspace.getActivePaneItem()
    file = editor?.buffer.file
    filePath = file?.path
    dir = path.dirname filePath

    switch process_architecture
      when 'linux'
        exec 'cd ' + dir + ' && git gui'
      # when 'darwin' then exec ('open "'+filePath+'"')
      # when 'win32' then Shell.openExternal('file:///'+filePath)

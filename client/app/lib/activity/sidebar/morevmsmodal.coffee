kd = require 'kd'
KDButtonView = kd.ButtonView
SidebarSearchModal = require './sidebarsearchmodal'
MachineItem = require './machineitem'
{handleNewMachineRequest} = require '../../providers/computehelpers'

module.exports = class MoreVMsModal extends SidebarSearchModal

  constructor: (options = {}, data) ->

    options.cssClass         = kd.utils.curry 'more-modal more-vms', options.cssClass
    options.width            = 462
    options.title          or= 'VMs'
    options.disableSearch    = yes
    options.itemClass      or= MachineItem
    options.bindModalDestroy = no

    super options, data

  viewAppended: ->

    @addButton = new KDButtonView
      title    : "Add VMs"
      style    : 'add-big-btn'
      icon     : yes
      loader   : yes
      callback : =>
        @addButton.showLoader()
        handleNewMachineRequest provider: 'koding', @bound 'destroy'

    @addSubView @addButton, '.kdmodal-content'

    super


  populate: ->

    machines = @getData()

    @listController.addItem machine.data for machine in machines

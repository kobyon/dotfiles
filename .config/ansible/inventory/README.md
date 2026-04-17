# Ansible inventory

Local inventory folder
Document describing how inventoy is loaded using my dotfiles

## How to use

Create links to inventoryes used for global hosts here.

Example:

```shell
ln -s ~/.local/src/sakkenix/inventory/ansible 10-sakkenix
```

The intention is to load inventory from multiple sources, but only have `group_vars` and `host_vars` from each repo where the varaibles is set.
However, sometimes we need to set local overrides.  Thiese overrides are defined in the submodule `.local/share/inventory/` and the `ansible-overrides` folder, and by default symlinked to `99-overrides`.

With this settup the following is acomplished

* All hosts from all ansible repos are available to the system.
* Only the variables defined in the active ansible repo is in use
* Overrides are applied for local customization

### Load order

The ansible inventory is loaded the following way:

* `ANSIBLE_INVENTORY` is set as environment variable: [profile](.config/shell/profile)
* `alias(1p)` is created for every ansible command: [aliasrc](.config/shell/aliasrc)

1. Hosts are collected from `ANSIBLE_INVENTORY` sub-folders
    1. `group_vars` and `host_vars` relative to sub-folders are not loaded.  This is a limitation of the inventory plugin
2. Whole inventory relative to `.` is loaded
    1. Here `group_vars` and `host_vars` are applied
3. `group_vars` and `host_vars` from `ANSIBLE_INVENTORY/99-overrides` is loaded

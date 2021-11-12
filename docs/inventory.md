# Hetzner and Terraform

Use a specific inventory.

```
bolt --inventoryfile inventory-tf-hzn.yaml
```

Show all nodes from an inventory

```
bolt inventory show
bolt --inventoryfile inventory-tf-hzn.yaml inventory show
```

Link specific inventory to standard inventory file.

```
ln -s inventory-tf-hzn.yaml inventory.yaml
```

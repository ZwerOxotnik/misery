--items.lua

data:extend({
  {
    type = "capsule",
    name = "medkit",
    icon = "__misery__/graphics/items/medkit.png",
    icon_size = 32,
    stack_size = 5,
    capsule_action =
    {
      type = "use-on-self",
      attack_parameters =
      {
        type = "projectile",
        ammo_category = "capsule",
        cooldown = 30,
        range = 0,
        ammo_type =
        {
          category = "capsule",
          target_type = "position",
          action =
          {
            type = "direct",
            action_delivery =
            {
              type = "instant",
              target_effects =
              {
                type = "damage",
                damage = {type = "physical", amount = -50}
              }
            }
          }
        }
      }
    },
  },
  {
    type = "capsule",
    name = "stimpack",
    icon = "__misery__/graphics/items/stimpack.png",
    icon_size = 32,
    stack_size = 10,
    capsule_action =
    {
      type = "use-on-self",
      attack_parameters =
      {
        type = "projectile",
        ammo_category = "capsule",
        cooldown = 30,
        range = 0,
        ammo_type =
        {
          category = "capsule",
          target_type = "position",
          action =
          {
            type = "direct",
            action_delivery =
            {
              type = "instant",
              target_effects =
              {
                type = "damage",
                damage = {type = "physical", amount = -250}
              }
            }
          }
        }
      }
    },
  },
  {
    type = "capsule",
    name = "suitCleaner",
    icon = "__misery__/graphics/items/suitCleaner.png",
    icon_size = 32,
    stack_size = 5,
    capsule_action =
    {
      type = "use-on-self",
      attack_parameters =
      {
        type = "projectile",
        ammo_category = "capsule",
        cooldown = 30,
        range = 0,
        ammo_type =
        {
          category = "capsule",
          target_type = "position",
          action =
          {
            type = "direct",
            action_delivery =
            {
              type = "instant",
              target_effects =
              {
                type = "damage",
                damage = {type = "physical", amount = 0}
              }
            }
          }
        }
      }
    },
  },
  {
    type = "capsule",
    name = "brainController",
    icon = "__misery__/graphics/items/brainController.png",
    icon_size = 32,
    stack_size = 5,
    capsule_action =
    {
      type = "use-on-self",
      attack_parameters =
      {
        type = "projectile",
        ammo_category = "capsule",
        cooldown = 30,
        range = 0,
        ammo_type =
        {
          category = "capsule",
          target_type = "position",
          action =
          {
            type = "direct",
            action_delivery =
            {
              type = "instant",
              target_effects =
              {
                type = "damage",
                damage = {type = "physical", amount = 0}
              }
            }
          }
        }
      }
    },
  },
  {
    type = "capsule",
    name = "vodka",
    icon = "__misery__/graphics/items/vodka.png",
    icon_size = 32,
    stack_size = 5,
    capsule_action =
    {
      type = "use-on-self",
      attack_parameters =
      {
        type = "projectile",
        ammo_category = "capsule",
        cooldown = 30,
        range = 0,
        ammo_type =
        {
          category = "capsule",
          target_type = "position",
          action =
          {
            type = "direct",
            action_delivery =
            {
              type = "instant",
              target_effects =
              {
                type = "damage",
                damage = {type = "physical", amount = 0}
              }
            }
          }
        }
      }
    },
  }
})
ActiveAdmin.register User do
  permit_params :login_id

  filter :login_id

  index do
    selectable_column
    column :id
    column :login_id
    column :created_at
    column :updated_at

    actions
  end

  show do
    attributes_table do
      row :id
      row :login_id
    end
  end

  form do |f|
    f.inputs do
      f.input :login_id
    end
    actions
  end

end

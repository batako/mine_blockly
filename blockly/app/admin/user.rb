ActiveAdmin.register User do
  permit_params :login_id, :role

  filter :login_id

  index do
    selectable_column
    column :id
    column :login_id
    column t('activerecord.attributes.user.role') do |user|
      user.role_i18n
    end
    column :created_at
    column :updated_at

    actions
  end

  show do
    attributes_table do
      row :id
      row :login_id
      row t('activerecord.attributes.user.role') do |user|
        user.role_i18n
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :login_id
      f.input :role,
        as: :select,
        collection: User.roles_i18n.invert,
        include_blank: false
    end
    actions
  end

end

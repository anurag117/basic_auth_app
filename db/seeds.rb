role = Role.find_or_create_by(role_type: 'admin')
User.find_or_create_by(first: 'admin', last: 'admin', email: 'admin@gmail.com') do |user|
  user.password = 'adminadmin'
  user.role_id = role.id
end

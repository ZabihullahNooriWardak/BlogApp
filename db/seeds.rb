# frozen_string_literal: true
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
third_user = User.create(name: 'Jose', photo: 'https://vivolabs.es/wp-content/uploads/2022/03/perfil-hombre-vivo.png', bio: 'Teacher from Poland.')

https://vivolabs.es/wp-content/uploads/2022/03/perfil-hombre-vivo.png

fourth_user = User.create(name: 'patricia', photo: 'https://b2472105.smushcdn.com/2472105/wp-content/uploads/2022/11/Fotografia-de-Retrato-18-1170x1170.jpg?lossy=1&strip=1&webp=1', bio: 'Teacher from Poland.')

fifth_user = User.create(name: 'Andrea', photo: 'https://b2472105.smushcdn.com/2472105/wp-content/uploads/2022/11/Fotografia-de-Retrato-18-1170x1170.jpg?lossy=1&strip=1&webp=1', bio: 'Teacher from Poland.')
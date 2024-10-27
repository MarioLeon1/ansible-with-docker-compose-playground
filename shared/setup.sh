# Clonar el repositorio
git clone https://github.com/Cloud-DevOps-Labs/ansible-with-docker-compose-playground

# Cambiar al directorio del proyecto
cd ansible-with-docker-compose-playground

# Levantar los contenedores con Docker Compose
docker-compose up -d

# Verificar que los contenedores están corriendo
docker ps

# Ejecutar el playbook ampliado
ansible-playbook -i /etc/ansible/hosts shared/recipe-extended.yml

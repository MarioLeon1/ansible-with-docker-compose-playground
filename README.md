# Ansible con Docker Compose Playground

Este repositorio contiene un entorno de pruebas para usar Ansible con Docker Compose, configurando múltiples contenedores Ubuntu con SSH y algunos playbooks básicos de Ansible.

## Comenzando

### 1. Clonar el repositorio

Ejecuta el siguiente comando para clonar el repositorio:

```bash
git clone https://github.com/Cloud-DevOps-Labs/ansible-with-docker-compose-playground
```

### 2. Acceder al directorio del proyecto

Una vez clonado, entra en la carpeta del proyecto:

```bash
cd ansible-with-docker-compose-playground
```

### 3. Iniciar los contenedores de Docker

Usa Docker Compose para levantar los contenedores en modo detach (en segundo plano):

```bash
docker-compose up -d
```

Esto creará y ejecutará los siguientes contenedores:
- `control`: El nodo principal de control
- `node1`, `node2`, `node3`: Tres nodos adicionales con servidores SSH instalados

Puedes verificar que los contenedores están en ejecución usando el siguiente comando:

```bash
docker ps
```

### 4. Ejecutar el Playbook

Una vez que los contenedores estén en funcionamiento, puedes usar Ansible para aplicar configuraciones. Se ha proporcionado un playbook base (`recipe-base.yml`), pero se pueden aplicar configuraciones adicionales utilizando un playbook extendido.

#### Ejecutar el playbook base:

```bash
ansible-playbook -i /etc/ansible/hosts shared/recipe-base.yml
```

#### Ejecutar el playbook extendido:

Hemos ampliado la configuración de Ansible para aprovechar los puertos abiertos en los nodos. El playbook extendido garantiza que SSH esté en funcionamiento, abre los puertos necesarios usando `iptables` y verifica la conectividad. Puedes ejecutar el playbook extendido usando:

```bash
ansible-playbook -i /etc/ansible/hosts shared/recipe-extended.yml
```

### 5. Automatización con un Script

Para automatizar todo el proceso de configuración (clonar el repositorio, iniciar contenedores y ejecutar el playbook extendido), se ha proporcionado un script llamado `setup.sh`. Puedes crear este archivo con el siguiente contenido:

```bash
#!/bin/bash

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
```

Haz el archivo ejecutable:

```bash
chmod +x setup.sh
```

Ejecuta el script para automatizar la configuración:

```bash
./setup.sh
```

### 6. Red y Puertos

Los contenedores exponen ciertos puertos para acceso externo:
- `node1`: Puertos 7001-7003 mapeados a 8001-8003
- `node2`: Puertos 8001-8003
- `node3`: Puertos 9001-9003 mapeados a 8001-8003

Estos puertos están abiertos para la comunicación entre nodos y pueden aprovecharse en tareas personalizadas de Ansible o en conexiones SSH manuales.

## Conclusión

Este entorno te permite experimentar con Docker y Ansible en un entorno controlado y aislado, donde puedes gestionar múltiples nodos fácilmente. El playbook extendido muestra cómo gestionar configuraciones de red y garantizar la disponibilidad de servicios en varios contenedores.

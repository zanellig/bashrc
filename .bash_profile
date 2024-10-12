if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Function to extract the HOST and PORT values from .env.local files
get_host_and_port_value() {
  local env_file=$1
  local host=$(grep -E '^HOST=' "$env_file" | cut -d'=' -f2)
  local port=$(grep -E '^PORT=' "$env_file" | cut -d'=' -f2)
  echo "$host:$port"
}

# Function to check if a systemd service (auditoria.prod or auditoria.dev) is running
check_service_running() {
  local service_name=$1
  if systemctl is-active --quiet "$service_name"; then
    return 0  # Service is active
  else
    return 1  # Service is not active
  fi
}

# Bash function to display host and port information with colors
bash_completions_for_hosts() {
  local prod_host_port=$(get_host_and_port_value ~/Auditoria/auditorIA-prod/.env.local)
  local dev_host_port=$(get_host_and_port_value ~/Auditoria/auditorIA-dev/.env.local)

  # Colors
  local BLUE='\e[34m'
  local GREEN='\e[32m'
  local RED='\e[31m'
  local RESET='\e[0m'

  # Check if systemd services are running
  local prod_running=false
  local dev_running=false

  if check_service_running "auditoria.prod"; then
    prod_running=true
  fi
  if check_service_running "auditoria.dev"; then
    dev_running=true
  fi

  # Display Prod host with colors
  if [ "$prod_running" = true ]; then
    echo -e "${GREEN}Prod host: ${BLUE}$prod_host_port ${GREEN}(running)${RESET}"
  else
    echo -e "${RED}Prod host: ${BLUE}$prod_host_port ${RED}(failure)${RESET}"
  fi

  # Display Dev host with colors
  if [ "$dev_running" = true ]; then
    echo -e "${GREEN}Dev host: ${BLUE}$dev_host_port ${GREEN}(running)${RESET}"
  else
    echo -e "${RED}Dev host: ${BLUE}$dev_host_port ${RED}(failure)${RESET}"
  fi
}

# Alias for printing the host and port info
alias show_hosts="bash_completions_for_hosts"
# Function to extract the HOST and PORT values from .env.local files
get_host_and_port_value() {
  local env_file=$1
  local host=$(grep -E '^HOST=' "$env_file" | cut -d'=' -f2)
  local port=$(grep -E '^PORT=' "$env_file" | cut -d'=' -f2)
  echo "$host:$port"
}

# Function to check if a systemd service (auditoria.prod or auditoria.dev) is running
check_service_running() {
  local service_name=$1
  if systemctl is-active --quiet "$service_name"; then
    return 0  # Service is active
  else
    return 1  # Service is not active
  fi
}

# Bash function to display host and port information with colors
bash_completions_for_hosts() {
  local prod_host_port=$(get_host_and_port_value ~/Auditoria/auditorIA-prod/.env.local)
  local dev_host_port=$(get_host_and_port_value ~/Auditoria/auditorIA-dev/.env.local)

  # Colors
  local BLUE='\e[34m'
  local GREEN='\e[32m'
  local RED='\e[31m'
  local RESET='\e[0m'

  # Check if systemd services are running
  local prod_running=false
  local dev_running=false

  if check_service_running "auditoria.prod"; then
    prod_running=true
  fi
  if check_service_running "auditoria.dev"; then
    dev_running=true
  fi

  # Display Prod host with colors
  if [ "$prod_running" = true ]; then
    echo -e "${GREEN}Prod host: ${BLUE}$prod_host_port ${GREEN}(running)${RESET}"
  else
    echo -e "${RED}Prod host: ${BLUE}$prod_host_port ${RED}(failure)${RESET}"
  fi

  # Display Dev host with colors
  if [ "$dev_running" = true ]; then
    echo -e "${GREEN}Dev host: ${BLUE}$dev_host_port ${GREEN}(running)${RESET}"
  else
    echo -e "${RED}Dev host: ${BLUE}$dev_host_port ${RED}(failure)${RESET}"
  fi
}

# Alias for printing the host and port info
alias show_hosts="bash_completions_for_hosts"

# Run show_hosts only if the shell is a login shell and show_hosts hasn't been run before
if [ -z "$SHOW_HOSTS_RUN" ]; then
  export SHOW_HOSTS_RUN=true
  show_hosts
  # Load node version
  nvm use 20.18
fi

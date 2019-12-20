function install_nginx_ingress() {
  local _env_file="$1"
  local _type="${2:-"LoadBalancer"}"  # NodePort or LoadBalancer
  local _ip="$3"  # LoadBalancer's IP address

  local _name="nginx-ingress"
  local _namespace="kube-system"
  local _values_file="${ROOT_DIR}/values/stable/nginx-ingress/values.yaml"

  if [ "${_type}" = "NodePort" ]; then
    helm install stable/nginx-ingress \
      --name "${_name}" \
      --namespace "${_namespace}" \
      -f "${_values_file}" \
      -f "${_env_file}" \
      -f "${ROOT_DIR}/values/stable/nginx-ingress/nodeport.yaml"
  else
    if [ "${_ip}" = "" ]; then
      echo "Please specify LoadBalancer's IP address!" 1>&2
      return 1
    fi
    helm install stable/nginx-ingress \
      --name "${_name}" \
      --namespace "${_namespace}" \
      -f "${_values_file}" \
      -f "${_env_file}" \
      --set "controller.service.loadBalancerIP=${_ip}"
  fi
}

### argoCDの環境構築
```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

### clusterの認証情報を確認
```bash
gcloud container clusters get-credentials [CLUSTER_NAME] --zone asia-northeast1 --project [PROJECT_ID]
```

### externalIPでホスティング
```bash
# ArgoCDのnamespaceに切り替え
kubectl config set-context --current --namespace=argocd
#　ArgoCD ServerのServiceをLoadBalancerに変更
kubectl patch svc argocd-server -p '{"spec": {"type": "LoadBalancer"}}'
# 外部IPの確認
kubectl get svc argocd-server
# ブラウザで開く
open http://$(kubectl get svc argocd-server -n argocd -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
# 初期パスワード取得 初期usernameはadmin
kubectl -n argocd get secret/argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

### argo Workflowの環境構築
```bash
# install
kubectl create namespace argo
kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v3.4.11/install.yaml
# argo-serverのServiceをLoadBalancerに変更
kubectl patch svc argo-server -n argo -p '{"spec": {"type": "LoadBalancer"}}'
# 外部IPの確認
kubectl get svc argo-server -n argo
# 認証を変更
kubectl patch deployment \
  argo-server \
  --namespace argo \
  --type='json' \
  -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/args", "value": [
  "server",
  "--auth-mode=server"
]}]'
# ブラウザで開く
export URL=https://$(kubectl get svc argo-server -n argo -o jsonpath='{.status.loadBalancer.ingress[0].ip}'):2746
open $URL
```

### argo Workflowの実行権限追加
```bash
# create serviceaccount
kubectl create serviceaccount argocd -n argocd
# apply role
kubectl apply -f role.yaml -n argocd
kubectl apply -f rolebinding.yaml -n argocd
```
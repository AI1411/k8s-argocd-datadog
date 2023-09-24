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

### create app
```bash
argocd app create first-step \
  --repo https://github.com/YOUR_REPO_URL.git \
  --path PATH_TO_YOUR_MANIFEST_DIRECTORY \
  --dest-namespace.yaml NAMESPACE_YOU_WANT_TO_DEPLOY \
  --dest-server https://kubernetes.default.svc \
  --sync-policy automated
```
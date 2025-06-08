               רואי אבני

## 🎮 פרוייקט סיום DevOps – Pacman על AWS

### 🧾 תאור כללי

בפרויקט זה פרסתי משחק Pacman באמצעות קוברנטיס (EKS) על תשתית בענן AWS
תוך שימוש ב־Terraform, GitHub Actions ו־CI/CD אוטומטי.
המערכת מאפשרת ניהול תשתית וקוד בצורה אוטומטית, רציפה, ומבוססת קוד (Infrastructure as Code).

---

### 🛠️ טכנולוגיות ושירותים עיקריים

* **AWS EKS** – קוברנטיס מנוהל להרצת הקונטיינרים  
* **EC2 Auto Scaling Group** – להרצת 2 נודים מסוג `t3.medium`  
* **Elastic Load Balancer** – חשיפה חיצונית של המשחק  
* **Terraform** – לבניית תשתיות  
* **GitHub Actions** – להרצת תהליך CI/CD  
* **kubectl** – לפריסה וניהול משאבים בקוברנטיס  

---

### ⚙️ שלבי הפרויקט

1. **שכפול קוד המשחק** מהמאגר GitHub של הפרויקט המקורי והעלאתו לריפו אישי  
2. **יצירת קבצי Terraform** להקמת EKS, Node Group, Networking ו־IAM Roles  
3. **שימוש ב־backend.tf** לניהול state ב־S3  
4. **הרצת terraform apply** להקמה בפועל של המשאבים בענן  
5. **פריסת הקבצים הקוברנטיים** (YAML) – יצירת Deployment ו־Service מסוג LoadBalancer  
6. **הגדרה ידנית של aws-auth ConfigMap** בגלל מגבלות ב־Terraform Provider  
7. **הוספת CI/CD עם GitHub Actions**:  
   * שלב 1: Terraform apply אוטומטי על כל שינוי  
   * שלב 2: kubectl apply אוטומטי על קבצי YAML  
8. **בדיקות סופיות** לוודא שיש 2 נודים, 2 פודים פעילים, והאתר מגיב דרך Load Balancer  
9. **שיפור קבצי YAML** – שינוי `replicas` ל־3 ולאחר מכן חזרה ל־2, והבדיקה הצליחה  

---

### 🔁 קונסיסטנטיות מלאה ב־CI/CD

המערכת כעת פועלת כך שכל שינוי בענף `main` של GitHub מביא ל־:  
* עדכון תשתיות בענן (Terraform)  
* עדכון שירותים ורפליקות במשחק (kubectl)  

---

### 🧠 אתגרים ופתרונות

* שימוש ב־Provider של קוברנטיס מתוך Terraform יצר שגיאות auth מול EKS ➜ נפתר ע״י הגדרה ידנית של ConfigMap  
* הסנכרון הראשוני בין GitHub ל־Terraform דרש יצירת secrets והפרדה לקבצים מתאימים (`terraform.tfvars`, `backend.tf`)  
* קובץ deployment היה צריך תיקון ל־replicas, והריצה נבדקה אוטומטית ב־GitHub Actions  

---

### 📸 צילומי מסך (ישולבו ב־PDF)

* קונסולת AWS – Cluster, Nodes, EC2, Load Balancer  
* פלט של `kubectl get pods`, `kubectl get nodes`  
* GitHub Actions – ריצות ירוקות מוצלחות  
* האתר עצמו דרך ה־Load Balancer  

---

### 🌐 קישור לאתר החי (Load Balancer)

> [http://<כתובת-loadbalancer>] – (להחליף עם הכתובת בפועל)

---

### 🧩 מבנה תיקיות

.
├── terraform/
│ ├── main.tf
│ ├── variables.tf
│ ├── backend.tf
│ └── terraform.tfvars
├── k8s/
│ ├── pacman-roiavni-deployment.yaml
│ └── pacman-roiavni-service.yaml
├── .github/workflows/
│ └── deploy.yml
├── public/ # קוד המקור של המשחק
├── server.js
├── app.js
└── Dockerfile


---

### 📦 שלב עתידי – Docker + ECR עבור Node.js

האפליקציה בנויה כ־Node.js מלא, כולל server.js ו־app.js, עם Dockerfile שמבצע התקנה והרצה.
ניתן לבנות Docker Image, לדחוף אותו ל־Amazon ECR
ולעדכן את ה־Deployment של Kubernetes לשימוש בתמונה הפרטית.

* מתאים לארגונים שרוצים שליטה בקוד ובגרסאות  
* מאפשר להרחיב בקלות את הלוגיקה בעתיד  
* מדגים CI/CD מלא – גם על קוד אפליקציה, לא רק תשתית  

💡 לא נדרש בפרויקט, אך רלוונטי מאוד בתעשייה  

---

### 🧠 מה למדתי

* איך בונים תשתיות ב־AWS בצורה אוטומטית ומודולרית (Terraform)  
* איך מחברים בין קוד, תשתית ופריסה (CI/CD מלא)  
* איך מתמודדים עם באגים כמו הרשאות EKS או פודים שנופלים  
* איך בודקים כל שינוי בגיטהאב ויודעים שהוא מגיע לענן באמת  

---

### ✅ מצב סיום

* [x] הקלאסטר פעיל  
* [x] המשחק פועל  
* [x] כל שינוי ב־GitHub ➜ מגיע לענן  
* [x] מוכנות מלאה להגשה  



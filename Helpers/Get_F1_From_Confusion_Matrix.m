function [f1,rec,pre] = Get_F1_From_Confusion_Matrix(cm)

n = sum(cm(1,:));

rec = diag(cm)/n;
pre = diag(cm)./sum(cm,1)';
f1 = 2*(pre.*rec)./(pre+rec);
f1(isnan(f1)) = 0;
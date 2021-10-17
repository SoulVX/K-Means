function [cost] = compute_cost_pc(points, centroids)
[NC d] = size(centroids);
[n d] = size(points);
cost = 0;
for i = 1:n
	val_min = norm(points(i,:)-centroids(1,:),2);
	for j = 2:NC
		if norm(points(i,:)-centroids(j,:),2) < val_min
			val_min = norm(points(i,:)-centroids(j,:),2);
		endif
	endfor
	cost = cost+val_min;
endfor
endfunction

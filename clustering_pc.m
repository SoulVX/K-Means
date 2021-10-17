function [centroids] = clustering_pc(points, NC)
[n d] = size(points);
clusters = zeros(n,d,NC);
centroids = zeros(NC,d);
nr_pct_in_clustere = zeros(NC);
for i = 1:n
	cluster_curent = mod(i,NC);
	if(cluster_curent == 0)
		cluster_curent = NC;
	endif
	nr_pct_in_clustere(cluster_curent) = nr_pct_in_clustere(cluster_curent) + 1;
	for j = 1:d
		clusters(nr_pct_in_clustere(cluster_curent), j, cluster_curent) = points(i, j);
	endfor
endfor
for i = 1:NC
	nr_pct_in_cluster = nr_pct_in_clustere(i);
	for j = 1:d
		suma_dimensiunilor = 0;
		for k = 1:nr_pct_in_cluster
			suma_dimensiunilor = suma_dimensiunilor + clusters(k,j,i);
		endfor
	centroids(i,j) = suma_dimensiunilor / nr_pct_in_cluster;
	endfor
endfor
EXIT = 0;
while EXIT == 0
	clusters = zeros(n,d,NC);
	nr_pct_in_clustere = zeros(NC);
	for i = 1:n
		val_min = norm(points(i,:)-centroids(1,:),2);
		ind_min = 1;
		for j = 2:NC
			dist = norm(points(i,:)-centroids(j,:),2);
			if(dist < val_min)
				val_min = dist;
				ind_min = j;
			endif
		endfor
		nr_pct_in_clustere(ind_min) = nr_pct_in_clustere(ind_min)+1;
		for j = 1:d
			clusters(nr_pct_in_clustere(ind_min), j , ind_min) = points(i, j);
		endfor
	endfor
	centroids_new = zeros(NC,d);
	for i = 1:NC
		nr_pct_in_cluster = nr_pct_in_clustere(i);
		for j = 1:d
			suma_dimensiunilor = 0;
				for k = 1:nr_pct_in_cluster
					suma_dimensiunilor = suma_dimensiunilor + clusters(k,j,i);
				endfor
				if nr_pct_in_cluster != 0
					centroids_new(i,j) = suma_dimensiunilor / nr_pct_in_cluster;
				else
				centroids_new(i,j) = centroids_old(i,j);
				endif
			endfor
		endfor
	if centroids == centroids_new
		EXIT = 1;
	endif
	centroids = centroids_new;
endwhile

endfunction
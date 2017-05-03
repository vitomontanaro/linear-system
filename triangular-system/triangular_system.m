function [ flag, x ] = triangular_system( A, b, type )
    
%   TRIANGULAR_SYSTEM
    
    %   Solve a triangular linear system Ax = b using back/forward
    %       substitution
    %   - Input -
    %   A = coefficient matrix
    %   b = constant terms
    %   type = matrix type ('upper' = upper triangular matrix;
    %          'lower' = lower triangular matrix)
    %   - Output -
    %   flag = boolean variable (1 = successful execution;
    %           0 = failed execution)
    %   x = unknowns
    
    flag = 0;
    x = 0;
    n = length(A);
    if (cond(A))    % determine if the matrix is nonsingular (with
                    %   condition number)
        if (type == 'upper')
            if (istriu(A))  % determine if matrix is upper triangular
                %   solve the triangular linear system using back substitution
                flag = 1;   
                x(n) = b(n) / A(n, n);
                for i = n - 1: -1: 1
                    tot = 0;
                    for j = i + 1: n
                        tot = tot + A(i, j) * x(j);
                    end
                    x(i) = (b(i) - tot) / A(i, i);
                end
            end
        else if (type == 'lower')
            if (istril(A))  % determine if matrix is lower triangular
                %   solve the triangular linear system using forward substitution
                flag = 1;   
                x(1) = b(1) / A(1, 1);
                for i = 2: n
                    tot = 0;
                    for j = 1: i - 1
                        tot = tot + A(i, j) * x(j);
                    end
                    x(i) = (b(i) - tot) / A(i, i);
                end
            end
            end
        end
    end
end

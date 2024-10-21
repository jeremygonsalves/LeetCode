class Solution(object):
    def largestOverlap(self, img1, img2):
        n = len(img1)

        def calculate_overlap(x_shift, y_shift):
            overlap = 0
            for i in range(n):
                for j in range(n):
                    # Ensure that we are within bounds after the shift
                    if 0 <= i + x_shift < n and 0 <= j + y_shift < n:
                        if img1[i][j] == 1 and img2[i + x_shift][j + y_shift] == 1:
                            overlap += 1
            return overlap

        # Try all shifts in both x and y directions
        max_overlap = 0
        for x_shift in range(-n + 1, n):
            for y_shift in range(-n + 1, n):
                max_overlap = max(max_overlap, calculate_overlap(x_shift, y_shift))
        
        return max_overlap

img1 = [[1, 1, 0], [0, 1, 0], [0, 1, 0]]
img2 = [[0, 0, 0], [0, 1, 1], [0, 0, 1]]

# Create an instance of the Solution class
solution = Solution()

# Call the largestOverlap method and print the result
print(solution.largestOverlap(img1, img2))  # Output: 3

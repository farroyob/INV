using System.ComponentModel.DataAnnotations;

namespace INV.Model.ViewModels
{
    public class Warehouse
    {
        [Key]
        public int Id { get; set; }
        [Required(ErrorMessage = "Name is required")]
        [MaxLength(100, ErrorMessage = "Name can't be more than {0} characters")]
        public string Name { get; set; } = string.Empty;
        [Required(ErrorMessage = "Description is required")]
        [MaxLength(255, ErrorMessage = "Name can't be more than {0} characters")]
        public string Description { get; set; } = string.Empty;
        public bool IsActive { get; set; }
    }
}

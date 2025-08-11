import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user.dart';
import '../bloc/auth_bloc.dart'; // Adjust path if needed
import 'package:anuel/core/router/router.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _termsAccepted = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (!_termsAccepted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please accept the terms & policy')),
        );
        return;
      }

      context.read<AuthBloc>().add(
            SignUpEvent(
              _nameController.text.trim(),
              _emailController.text.trim(),
              _passwordController.text.trim(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Registration successful! Welcome ${state.user.name}!')),
            );
            Navigator.pushReplacementNamed(context, AppRouter.signin);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Color(0xFF3F51FF),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: const Text(
                          'ECOM',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3F51FF),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  const Center(
                    child: Text(
                      'Create your account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Name
                  _buildLabel('Name'),
                  _buildTextField(_nameController, hint: 'ex: jon smith', validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter your name';
                    return null;
                  }),
                  const SizedBox(height: 16),

                  // Email
                  _buildLabel('Email'),
                  _buildTextField(_emailController,
                      hint: 'ex: jon.smith@email.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Please enter your email';
                        if (!value.contains('@')) return 'Please enter a valid email';
                        return null;
                      }),
                  const SizedBox(height: 16),

                  // Password
                  _buildLabel('Password'),
                  _buildTextField(_passwordController,
                      hint: '••••••••',
                      obscureText: _obscurePassword,
                      suffixIcon: _buildToggleIcon(() {
                        setState(() => _obscurePassword = !_obscurePassword);
                      }, _obscurePassword),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Please enter a password';
                        if (value.length < 6) return 'Password must be at least 6 characters';
                        return null;
                      }),
                  const SizedBox(height: 16),

                  // Confirm Password
                  _buildLabel('Confirm password'),
                  _buildTextField(_confirmPasswordController,
                      hint: '••••••••',
                      obscureText: _obscureConfirmPassword,
                      suffixIcon: _buildToggleIcon(() {
                        setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                      }, _obscureConfirmPassword),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Please confirm your password';
                        if (value != _passwordController.text) return 'Passwords do not match';
                        return null;
                      }),
                  const SizedBox(height: 16),

                  // Terms Checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: _termsAccepted,
                        onChanged: (value) => setState(() => _termsAccepted = value!),
                        activeColor: const Color(0xFF3F51FF),
                      ),
                      const Text('I understood the terms & policy.', style: TextStyle(color: Colors.black87)),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3F51FF),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'SIGN UP',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Sign In Link
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, AppRouter.signin);
                      },
                      child: RichText(
                        text: const TextSpan(
                          text: "Have an account?",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                          children: [
                            TextSpan(
                              text: " SIGN IN",
                              style: TextStyle(color: Color(0xFF3F51FF)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(text, style: const TextStyle(fontSize: 16, color: Colors.black87));
  }

  Widget _buildTextField(TextEditingController controller,
      {String? hint,
      bool obscureText = false,
      Widget? suffixIcon,
      TextInputType keyboardType = TextInputType.text,
      String? Function(String?)? validator}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: suffixIcon,
        ),
        style: const TextStyle(color: Colors.black87),
        validator: validator,
      ),
    );
  }

  Widget _buildToggleIcon(VoidCallback onPressed, bool isObscured) {
    return IconButton(
      icon: Icon(isObscured ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
      onPressed: onPressed,
    );
  }
}

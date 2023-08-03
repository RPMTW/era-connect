use tokio::sync::RwLock;

use super::ui_layout::UILayout;

pub struct ConfigState {
    pub ui_layout: RwLock<UILayout>,
}

impl ConfigState {
    pub fn new() -> Self {
        let ui_layout_result = UILayout::load();
        let ui_layout = match ui_layout_result {
            Ok(ui_layout) => ui_layout,
            Err(e) => {
                log::error!("Failed to load UI layout config: {}", e);
                UILayout::default()
            }
        };

        Self {
            ui_layout: RwLock::new(ui_layout),
        }
    }
}
